import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/providers/app_providers.dart';
import '../../core/constants/api_constants.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    if (!appState.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to Habari Sasa',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to access your profile and personalized content',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to login
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to register
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final user = appState.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: user?.profilePic != null
                  ? CachedNetworkImageProvider(
                      '${ApiConstants.photoPath}/${user!.profilePic}',
                    )
                  : null,
              child: user?.profilePic == null
                  ? const Icon(Icons.person, size: 50, color: Colors.grey)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'User',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (user?.email != null)
              Text(
                user!.email!,
                style: TextStyle(color: Colors.grey[600]),
              ),
            const SizedBox(height: 24),
            const Divider(),
            _buildMenuItem(
              icon: Icons.favorite_outline,
              title: 'Favourites',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.bookmark_outline,
              title: 'Saved Articles',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.history,
              title: 'Reading History',
              onTap: () {},
            ),
            const Divider(),
            _buildMenuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.language,
              title: 'Language',
              trailing: 'English',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              trailing: 'Off',
              onTap: () {},
            ),
            const Divider(),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              textColor: Colors.red,
              onTap: () {
                ref.read(appStateProvider.notifier).setLoggedIn(false);
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? trailing,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: trailing != null
          ? Text(trailing, style: TextStyle(color: Colors.grey[600]))
          : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
