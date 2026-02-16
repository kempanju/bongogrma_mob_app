import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart' as badges;
import '../posts/posts_feed.dart';
import '../discover/discover_screen.dart';
import '../chat/chat_list_screen.dart';
import '../posts/create_post_screen.dart';
import '../../core/providers/app_providers.dart';
import '../../core/constants/api_constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  String _headerTitle = 'Stories';

  final List<Widget> _screens = [
    const PostsFeed(),
    const DiscoverScreen(),
    const CreatePostScreen(),
    const ChatListScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _headerTitle = 'Stories';
          break;
        case 1:
          _headerTitle = 'Discover';
          break;
        case 2:
          _headerTitle = 'Add Item';
          break;
        case 3:
          _headerTitle = 'Messages';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: const AssetImage('assets/images/appicon.png'),
            backgroundColor: Colors.grey[200],
          ),
        ),
        title: Text(_headerTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          badges.Badge(
            showBadge: appState.notificationCount > 0,
            badgeContent: Text(
              '${appState.notificationCount}',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => context.push('/notifications'),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => context.push('/profile'),
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[300],
                backgroundImage: appState.isLoggedIn && appState.currentUser?.profilePic != null
                    ? CachedNetworkImageProvider(
                        '${ApiConstants.photoPath}/${appState.currentUser!.profilePic}',
                      )
                    : null,
                child: !appState.isLoggedIn || appState.currentUser?.profilePic == null
                    ? const Icon(Icons.person, size: 20, color: Colors.grey)
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Discover',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              showBadge: appState.messageCount > 0,
              badgeContent: Text(
                '${appState.messageCount}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: const Icon(Icons.chat_bubble_outline),
            ),
            activeIcon: badges.Badge(
              showBadge: appState.messageCount > 0,
              badgeContent: Text(
                '${appState.messageCount}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: const Icon(Icons.chat_bubble),
            ),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}
