import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FollowScreen extends StatefulWidget {
  final int userId;
  final bool showFollowers; // true = followers, false = following

  const FollowScreen({
    super.key,
    required this.userId,
    required this.showFollowers,
  });

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.showFollowers ? 0 : 1,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connections'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Followers'),
            Tab(text: 'Following'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUserList(isFollowers: true),
          _buildUserList(isFollowers: false),
        ],
      ),
    );
  }

  Widget _buildUserList({required bool isFollowers}) {
    // Sample data
    final users = List.generate(
      15,
      (index) => {
        'id': index + 1,
        'name': 'User ${index + 1}',
        'username': '@user${index + 1}',
        'avatar': 'https://i.pravatar.cc/150?img=${index + 1}',
        'isFollowing': index % 3 == 0,
      },
    );

    if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFollowers ? Icons.people_outline : Icons.person_add_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isFollowers ? 'No followers yet' : 'Not following anyone',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user['avatar'] as String),
          ),
          title: Text(
            user['name'] as String,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(user['username'] as String),
          trailing: (user['isFollowing'] as bool)
              ? OutlinedButton(
                  onPressed: () {
                    // Unfollow
                  },
                  child: const Text('Following'),
                )
              : ElevatedButton(
                  onPressed: () {
                    // Follow
                  },
                  child: const Text('Follow'),
                ),
          onTap: () {
            // Navigate to user profile
          },
        );
      },
    );
  }
}
