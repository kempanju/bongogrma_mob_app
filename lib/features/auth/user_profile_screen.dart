import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'auth_provider.dart';
import '../../core/constants/api_constants.dart';

class UserProfileScreen extends ConsumerWidget {
  final int? userId;

  const UserProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isOwnProfile = userId == null || userId == authState.user?.id;

    // For viewing other users' profiles, you'd fetch their data
    // For now, we'll show the current user's profile
    final user = authState.user;

    if (!authState.isAuthenticated || user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text('Please login to view profile'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.push('/auth/login'),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                actions: [
                  if (isOwnProfile)
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {
                        // Navigate to settings
                      },
                    ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withAlpha(180),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            backgroundImage: user.profilePic != null
                                ? CachedNetworkImageProvider(
                                    '${ApiConstants.photoPath}/${user.profilePic}',
                                  )
                                : null,
                            child: user.profilePic == null
                                ? const Icon(Icons.person, size: 45, color: Colors.grey)
                                : null,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            user.name ?? 'User',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (user.email != null)
                            Text(
                              user.email!,
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('Posts', '12'),
                      _buildStatColumn('Followers', '256'),
                      _buildStatColumn('Following', '180'),
                    ],
                  ),
                ),
              ),
              if (isOwnProfile)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: OutlinedButton(
                      onPressed: () => context.push('/auth/complete-profile'),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ),
              if (!isOwnProfile)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Follow'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Message'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: const [
                      Tab(icon: Icon(Icons.grid_on), text: 'Posts'),
                      Tab(icon: Icon(Icons.bookmark_outline), text: 'Saved'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Posts Grid
              GridView.builder(
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/seed/post$index/200',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[200]),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image),
                    ),
                  );
                },
              ),
              // Saved Posts
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_outline, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No saved posts yet',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
