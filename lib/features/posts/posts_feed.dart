import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'posts_provider.dart';
import '../../shared/widgets/post_card.dart';
import '../../shared/widgets/shimmer_loading.dart';

class PostsFeed extends ConsumerWidget {
  const PostsFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postsProvider);

    if (postsState.isLoading && postsState.posts.isEmpty) {
      return const ShimmerLoading();
    }

    if (postsState.hasError && postsState.posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Failed to load posts',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(postsProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(postsProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: postsState.posts.length + (postsState.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= postsState.posts.length) {
            // Load more indicator
            if (postsState.hasMore && !postsState.isLoading) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(postsProvider.notifier).loadPosts();
              });
            }
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final post = postsState.posts[index];
          return PostCard(
            post: post,
            onTap: () => context.push('/post/${post.id}', extra: post.title),
            onShare: () {
              Share.share(
                '${post.title}\n\n${post.postLink ?? ""}',
                subject: 'Habari Sasa',
              );
            },
          );
        },
      ),
    );
  }
}
