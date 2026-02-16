import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications
    final notifications = [
      {
        'title': 'New article published',
        'body': 'Check out the latest news about Tanzania',
        'time': '2 hours ago',
        'isRead': false,
        'type': 'article',
      },
      {
        'title': 'Someone liked your post',
        'body': 'User123 liked your post about football',
        'time': '5 hours ago',
        'isRead': false,
        'type': 'like',
      },
      {
        'title': 'New message',
        'body': 'You have a new message from John',
        'time': '1 day ago',
        'isRead': true,
        'type': 'message',
      },
      {
        'title': 'Weekly digest',
        'body': 'Your weekly summary is ready',
        'time': '2 days ago',
        'isRead': true,
        'type': 'digest',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Container(
                  color: notification['isRead'] as bool
                      ? null
                      : Theme.of(context).primaryColor.withAlpha(12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getNotificationColor(notification['type'] as String),
                      child: Icon(
                        _getNotificationIcon(notification['type'] as String),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      notification['title'] as String,
                      style: TextStyle(
                        fontWeight: notification['isRead'] as bool
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['body'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification['time'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    onTap: () {
                      // Handle notification tap
                    },
                  ),
                );
              },
            ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'article':
        return Icons.article;
      case 'like':
        return Icons.favorite;
      case 'message':
        return Icons.chat_bubble;
      case 'digest':
        return Icons.summarize;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'article':
        return Colors.blue;
      case 'like':
        return Colors.red;
      case 'message':
        return Colors.green;
      case 'digest':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
