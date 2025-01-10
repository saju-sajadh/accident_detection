import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, Object>> _notifications = [
    {'title': 'New Help Center Added', 'isRead': false},
    {'title': 'Scheduled Maintenance Update', 'isRead': false},
    {'title': 'App Update Available', 'isRead': true},
    {'title': 'Emergency Alert: High Traffic', 'isRead': false},
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        automaticallyImplyLeading: false,
        title: const Text(
          'Notifications',
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text(
              'Mark All as Read',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
        elevation: 8.0,
      ),
      body: Container(
        color: Colors.grey[700],
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return Card(
              color: notification['isRead'] as bool
                  ? Colors.grey[800]
                  : Colors.grey[900],
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(
                  notification['title'] as String,
                  style: TextStyle(
                    color: notification['isRead'] as bool
                        ? Colors.white70
                        : Colors.white,
                    fontWeight: notification['isRead'] as bool
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                trailing: notification['isRead'] as bool
                    ? null
                    : IconButton(
                        icon: const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                        onPressed: () => _markAsRead(index),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
