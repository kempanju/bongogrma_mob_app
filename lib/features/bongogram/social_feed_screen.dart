import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../core/constants/api_constants.dart';
import '../../data/models/social_post.dart';
import 'bongogram_provider.dart';

class SocialFeedScreen extends ConsumerWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(socialFeedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: feedState.isLoading && feedState.posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(socialFeedProvider.notifier).refreshPosts(),
              child: ListView.builder(
                itemCount: feedState.posts.length,
                itemBuilder: (context, index) {
                  return SocialPostCard(
                    post: feedState.posts[index],
                    onLike: () => ref.read(socialFeedProvider.notifier).toggleLike(feedState.posts[index].id),
                  );
                },
              ),
            ),
    );
  }
}

class SocialPostCard extends StatelessWidget {
  final SocialPost post;
  final VoidCallback onLike;

  const SocialPostCard({
    super.key,
    required this.post,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: post.ownerProfilePic != null
                  ? CachedNetworkImageProvider(
                      '${ApiConstants.photoPath}/${post.ownerProfilePic}',
                    )
                  : null,
              child: post.ownerProfilePic == null
                  ? Text(post.ownerName[0].toUpperCase())
                  : null,
            ),
            title: Text(
              post.ownerName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(timeago.format(post.datePosted)),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showPostOptions(context),
            ),
          ),

          // Description
          if (post.description != null && post.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(post.description!),
            ),

          // Media Content
          if (post.isImage || post.isVideo)
            _buildMediaContent(context),

          if (post.isAudio)
            _buildAudioPlayer(context),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                if (post.likesCount > 0)
                  Text(
                    '${post.likesCount} likes',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                if (post.likesCount > 0 && post.commentsCount > 0)
                  Text(' • ', style: TextStyle(color: Colors.grey[600])),
                if (post.commentsCount > 0)
                  Text(
                    '${post.commentsCount} comments',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                if (post.isVideo && post.viewsCount > 0) ...[
                  Text(' • ', style: TextStyle(color: Colors.grey[600])),
                  Text(
                    '${post.viewsCount} views',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ],
            ),
          ),

          const Divider(height: 1),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: onLike,
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: post.isLiked ? Colors.red : Colors.grey[600],
                    size: 20,
                  ),
                  label: Text(
                    'Like',
                    style: TextStyle(
                      color: post.isLiked ? Colors.red : Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _openComments(context),
                  icon: Icon(Icons.comment_outlined, color: Colors.grey[600], size: 20),
                  label: Text('Comment', style: TextStyle(color: Colors.grey[600])),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _sharePost(context),
                  icon: Icon(Icons.share_outlined, color: Colors.grey[600], size: 20),
                  label: Text('Share', style: TextStyle(color: Colors.grey[600])),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediaContent(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPostDetail(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: '${ApiConstants.thumbnailPath}/${post.imageName}',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image, size: 50),
              ),
            ),
          ),
          if (post.isVideo)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
            ),
          if (post.isVideo && post.videoDuration != null)
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatDuration(post.videoDuration!),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.music_note, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Audio',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 0,
                  backgroundColor: Colors.grey[300],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.play_circle_filled),
            iconSize: 40,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              // Play audio
            },
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: const Text('Save Post'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Copy Link'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text('Report'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _openComments(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(postId: post.id, post: post),
      ),
    );
  }

  void _openPostDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SocialPostDetailScreen(post: post),
      ),
    );
  }

  void _sharePost(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon')),
    );
  }
}

class CommentsScreen extends ConsumerStatefulWidget {
  final int postId;
  final SocialPost post;

  const CommentsScreen({super.key, required this.postId, required this.post});

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() {
    if (_commentController.text.trim().isEmpty) return;

    ref.read(commentsProvider(widget.postId).notifier).addComment(
          _commentController.text.trim(),
          'Current User',
          null,
        );
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final commentsState = ref.watch(commentsProvider(widget.postId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          // Post header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(widget.post.ownerName[0]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.ownerName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (widget.post.description != null)
                        Text(widget.post.description!),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Comments list
          Expanded(
            child: commentsState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : commentsState.comments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chat_bubble_outline,
                                size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No comments yet',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const Text('Be the first to comment!'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: commentsState.comments.length,
                        itemBuilder: (context, index) {
                          final comment = commentsState.comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(comment.userName[0]),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  comment.userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  timeago.format(comment.datePosted),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(comment.content),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    comment.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 18,
                                    color: comment.isLiked ? Colors.red : null,
                                  ),
                                  onPressed: () => ref
                                      .read(commentsProvider(widget.postId).notifier)
                                      .toggleLike(comment.id),
                                ),
                                if (comment.likesCount > 0)
                                  Text(
                                    '${comment.likesCount}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
          ),

          // Comment input
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 18, child: Icon(Icons.person, size: 20)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                  onPressed: _submitComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialPostDetailScreen extends StatelessWidget {
  final SocialPost post;

  const SocialPostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            ListTile(
              leading: CircleAvatar(
                child: Text(post.ownerName[0]),
              ),
              title: Text(post.ownerName),
              subtitle: Text(timeago.format(post.datePosted)),
            ),

            // Media
            if (post.isImage || post.isVideo)
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: '${ApiConstants.thumbnailPath}/${post.imageName}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 50),
                  ),
                ),
              ),

            // Description
            if (post.description != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  post.description!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${post.likesCount} likes • ${post.commentsCount} comments',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
