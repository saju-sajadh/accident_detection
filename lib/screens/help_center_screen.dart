import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  Position? _currentPosition;
  String? _nearestLocation;
  String? _selectedLocation;
  bool _isAutoMode = true; // Default is Auto mode

  final List<Map<String, Object>> _locations = [
    {'name': 'Location A', 'latitude': 40.7128, 'longitude': -74.0060},
    {'name': 'Location B', 'latitude': 34.0522, 'longitude': -118.2437},
    {'name': 'Location C', 'latitude': 51.5074, 'longitude': -0.1278},
    {'name': 'Location D', 'latitude': 28.7041, 'longitude': 77.1025},
  ];

  @override
  void initState() {
    super.initState();
    if (_isAutoMode) {
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _nearestLocation = _findNearestLocation(position);
    });
  }

  String _findNearestLocation(Position currentPosition) {
    double calculateDistance(
        double lat1, double lon1, double lat2, double lon2) {
      const double p = 0.017453292519943295; // pi / 180
      final double a = 0.5 -
          cos((lat2 - lat1) * p) / 2 +
          cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a)); // 2 * R * asin...
    }

    String nearestLocation = _locations.first['name'] as String;
    double minDistance = calculateDistance(
      currentPosition.latitude,
      currentPosition.longitude,
      _locations.first['latitude'] as double,
      _locations.first['longitude'] as double,
    );

    for (var location in _locations) {
      final distance = calculateDistance(
        currentPosition.latitude,
        currentPosition.longitude,
        location['latitude'] as double,
        location['longitude'] as double,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestLocation = location['name'] as String;
      }
    }

    return nearestLocation;
  }

  void _showSwitchModeWarning() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Switch to Manual Mode?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '''Auto mode is recommended for better functionality. Are you sure you want to switch to manual mode?''',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isAutoMode = false;
                _nearestLocation = null; // Clear nearest location
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Switch',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          automaticallyImplyLeading: false,
          title: const Text(
            'Help Centers',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white),
          ),
          elevation: 8.0,
        ),
        body: Container(
          color: Colors.grey[800],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radio Buttons to switch between Auto and Manual mode
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _isAutoMode,
                      onChanged: (value) {
                        setState(() {
                          _isAutoMode = value!;
                          if (_isAutoMode) {
                            _getCurrentLocation();
                          }
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    const Text(
                      'Auto',
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio<bool>(
                      value: false,
                      groupValue: _isAutoMode,
                      onChanged: (value) {
                        if (value == false) {
                          _showSwitchModeWarning();
                        }
                      },
                      activeColor: Colors.red,
                    ),
                    const Text(
                      'Manual',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Nearest Help Center:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                _isAutoMode
                    ? DropdownButtonFormField<String>(
                        value: _nearestLocation,
                        items: _locations
                            .map((location) => DropdownMenuItem<String>(
                                  value: location['name'] as String,
                                  child: Text(
                                    location['name'] as String,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList(),
                        onChanged:
                            null, // User cannot change the dropdown value
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[900],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        disabledHint: Text(
                          _nearestLocation ?? 'Fetching nearest location...',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : DropdownButtonFormField<String>(
                        value: _selectedLocation,
                        items: _locations
                            .map((location) => DropdownMenuItem<String>(
                                  value: location['name'] as String,
                                  child: Text(
                                    location['name'] as String,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLocation = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[900],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        dropdownColor: Colors.grey[700],
                      ),
                const Spacer(),
                // Description at the bottom
                const Text(
                  '''This feature helps you find the nearest help center based on your current location or allows you to manually select a help center from the list.''',
                  style: TextStyle(color: Colors.white70, fontSize: 12.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
