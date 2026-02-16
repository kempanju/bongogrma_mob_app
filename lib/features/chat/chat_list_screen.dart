import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    if (!appState.isLoggedIn) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Login to Chat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Connect with others by logging in',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate to login
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    // Sample chat data
    final chats = List.generate(
      10,
      (index) => {
        'name': 'User ${index + 1}',
        'lastMessage': 'This is the last message from user ${index + 1}',
        'time': '${index + 1}h ago',
        'unread': index < 3 ? index + 1 : 0,
        'avatar': 'https://i.pravatar.cc/150?img=${index + 1}',
      },
    );

    return ListView.separated(
      itemCount: chats.length,
      separatorBuilder: (context, index) => const Divider(height: 1, indent: 72),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: CachedNetworkImageProvider(chat['avatar'] as String),
          ),
          title: Text(
            chat['name'] as String,
            style: TextStyle(
              fontWeight: (chat['unread'] as int) > 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(
            chat['lastMessage'] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: (chat['unread'] as int) > 0 ? Colors.black87 : Colors.grey[600],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat['time'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: (chat['unread'] as int) > 0 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey[500],
                ),
              ),
              if ((chat['unread'] as int) > 0) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${chat['unread']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {
            // Navigate to chat detail
          },
        );
      },
    );
  }
}
