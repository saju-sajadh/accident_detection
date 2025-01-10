import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG icons

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  static const Color primary = Color(0xFF00AD48);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5), // Slightly darker at the top
                    Colors.black.withOpacity(0.9), // Slightly
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.45, // 45% height
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning,
                      size: 50.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Accident Detection',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      'Crash Advisor is here to help.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45, // Below
              left: 20.0, // Add some left padding
              right: 20.0, // Add some right padding
              // ignore: lines_longer_than_80_chars
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Align
                children: [
                  SizedBox(height: 20),
                  // Row 1 - Text with leading tick mark
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Make sure you and others are OK',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Roboto' // Or your preferred font
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0), // Add spacing between rows
                  // Row 2 - Text with leading tick mark
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Move your vehicle out of the way of traffic',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: 'Roboto', // Or your preferred font
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0), // Add spacing between rows
                  // Row 3 - Text with leading tick mark
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Do not admit fault to anyone',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: 'Roboto', // Or your preferred font
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0), // Add spacing below tick marks
                  Text(
                    'Report details about the accident',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Roboto', // Or your preferred font
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '''Easily capture crash details, notify your insurance carrier, and book concierge''',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Roboto', // Or your preferred font
                    ),
                  ),
                  const SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: Text(
                      'Authenticate',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width - 40, 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
