import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../core/constants/api_constants.dart';
import 'tags_provider.dart';

class TagsScreen extends ConsumerWidget {
  final String? initialTag;

  const TagsScreen({super.key, this.initialTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsState = ref.watch(tagsProvider);

    // Load posts for initial tag if provided
    if (initialTag != null && tagsState.selectedTag != initialTag) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(tagsProvider.notifier).loadPostsByTag(initialTag!);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tagsState.selectedTag ?? 'Trending Tags'),
        actions: [
          if (tagsState.selectedTag != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                ref.read(tagsProvider.notifier).clearSelectedTag();
              },
            ),
        ],
      ),
      body: tagsState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : tagsState.selectedTag != null
              ? _buildTagPosts(context, ref, tagsState)
              : _buildTrendingTags(context, ref, tagsState),
    );
  }

  Widget _buildTrendingTags(BuildContext context, WidgetRef ref, TagsState state) {
    final trendingTags = state.trendingTags.where((t) => t.isTrending).toList();
    final otherTags = state.trendingTags.where((t) => !t.isTrending).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (trendingTags.isNotEmpty) ...[
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.red[400], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Trending Now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: trendingTags.map((tag) => _TagChip(
              tag: tag,
              onTap: () => ref.read(tagsProvider.notifier).loadPostsByTag(tag.name),
            )).toList(),
          ),
          const SizedBox(height: 24),
        ],
        if (otherTags.isNotEmpty) ...[
          const Text(
            'Popular Tags',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...otherTags.map((tag) => _TagListItem(
            tag: tag,
            onTap: () => ref.read(tagsProvider.notifier).loadPostsByTag(tag.name),
          )),
        ],
      ],
    );
  }

  Widget _buildTagPosts(BuildContext context, WidgetRef ref, TagsState state) {
    if (state.tagPosts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.tag, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No posts found for ${state.selectedTag}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: state.tagPosts.length,
      itemBuilder: (context, index) {
        final post = state.tagPosts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Text(post.ownerName[0]),
                ),
                title: Text(post.ownerName),
                subtitle: Text(timeago.format(post.datePosted)),
              ),
              if (post.description != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(post.description!),
                ),
              if (post.imageName != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConstants.thumbnailPath}/${post.imageName}',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 200,
                        color: Colors.grey[200],
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.favorite_border, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('${post.likesCount}', style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.comment_outlined, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('${post.commentsCount}', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TagChip extends StatelessWidget {
  final Tag tag;
  final VoidCallback onTap;

  const _TagChip({required this.tag, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tag.name),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(50),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _formatCount(tag.postCount),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      onPressed: onTap,
      backgroundColor: Colors.grey[100],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

class _TagListItem extends StatelessWidget {
  final Tag tag;
  final VoidCallback onTap;

  const _TagListItem({required this.tag, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.tag,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(
        tag.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text('${tag.postCount} posts'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
