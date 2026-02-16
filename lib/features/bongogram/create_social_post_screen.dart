import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/app_providers.dart';

class CreateSocialPostScreen extends ConsumerStatefulWidget {
  const CreateSocialPostScreen({super.key});

  @override
  ConsumerState<CreateSocialPostScreen> createState() => _CreateSocialPostScreenState();
}

class _CreateSocialPostScreenState extends ConsumerState<CreateSocialPostScreen> {
  final _contentController = TextEditingController();
  int _contentType = 0; // 0=text, 1=image, 2=video, 6=audio
  String? _selectedMediaPath;
  bool _isPosting = false;
  bool _isAd = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // Image picker implementation
    setState(() {
      _contentType = 1;
      _selectedMediaPath = 'sample_image.jpg';
    });
  }

  Future<void> _pickVideo() async {
    // Video picker implementation
    setState(() {
      _contentType = 2;
      _selectedMediaPath = 'sample_video.mp4';
    });
  }

  Future<void> _pickAudio() async {
    // Audio picker implementation
    setState(() {
      _contentType = 6;
      _selectedMediaPath = 'sample_audio.mp3';
    });
  }

  void _removeMedia() {
    setState(() {
      _contentType = 0;
      _selectedMediaPath = null;
    });
  }

  Future<void> _submitPost() async {
    if (_contentController.text.trim().isEmpty && _selectedMediaPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add some content')),
      );
      return;
    }

    setState(() => _isPosting = true);

    try {
      // Simulate posting
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created successfully!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isPosting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);

    if (!appState.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Create Post')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text('Please login to create posts'),
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
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: _isPosting ? null : _submitPost,
            child: _isPosting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Post'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info row
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
                  child: Text(
                    appState.currentUser?.name?.substring(0, 1).toUpperCase() ?? 'U',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appState.currentUser?.name ?? 'User',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Public',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Content input
            TextField(
              controller: _contentController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border: InputBorder.none,
              ),
              onChanged: (_) => setState(() {}),
            ),

            // Selected media preview
            if (_selectedMediaPath != null) ...[
              const SizedBox(height: 16),
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _contentType == 1
                                ? Icons.image
                                : _contentType == 2
                                    ? Icons.videocam
                                    : Icons.audiotrack,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _selectedMediaPath!,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _removeMedia,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            // Is Ad toggle
            SwitchListTile(
              title: const Text('This is an advertisement'),
              subtitle: const Text('Mark as sponsored content'),
              value: _isAd,
              onChanged: (value) => setState(() => _isAd = value),
              contentPadding: EdgeInsets.zero,
            ),

            const Divider(),

            // Media buttons
            const Text(
              'Add to your post',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _MediaButton(
                  icon: Icons.image,
                  label: 'Photo',
                  color: Colors.green,
                  onTap: _pickImage,
                ),
                const SizedBox(width: 12),
                _MediaButton(
                  icon: Icons.videocam,
                  label: 'Video',
                  color: Colors.red,
                  onTap: _pickVideo,
                ),
                const SizedBox(width: 12),
                _MediaButton(
                  icon: Icons.audiotrack,
                  label: 'Audio',
                  color: Colors.purple,
                  onTap: _pickAudio,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MediaButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
