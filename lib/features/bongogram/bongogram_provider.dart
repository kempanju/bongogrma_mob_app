import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/social_post.dart';

class SocialFeedState {
  final List<SocialPost> posts;
  final bool isLoading;
  final bool hasMore;
  final String? errorMessage;

  SocialFeedState({
    this.posts = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.errorMessage,
  });

  SocialFeedState copyWith({
    List<SocialPost>? posts,
    bool? isLoading,
    bool? hasMore,
    String? errorMessage,
  }) {
    return SocialFeedState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }
}

class SocialFeedNotifier extends StateNotifier<SocialFeedState> {
  SocialFeedNotifier() : super(SocialFeedState()) {
    loadPosts();
  }

  Future<void> loadPosts() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Sample posts data
      final samplePosts = [
        SocialPost(
          id: 1,
          ownerId: 1,
          ownerName: 'John Doe',
          ownerProfilePic: 'default.jpg',
          description: 'Beautiful sunset today! 🌅 #nature #photography',
          imageName: 'sunset.jpg',
          contentType: 1,
          likesCount: 45,
          commentsCount: 12,
          viewsCount: 230,
          datePosted: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        SocialPost(
          id: 2,
          ownerId: 2,
          ownerName: 'Jane Smith',
          ownerProfilePic: 'jane.jpg',
          description: 'Check out this amazing video! 🎬',
          imageName: 'video_thumb.jpg',
          videoThumb: 'video.mp4',
          contentType: 2,
          likesCount: 120,
          commentsCount: 34,
          viewsCount: 1500,
          videoDuration: 180,
          datePosted: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        SocialPost(
          id: 3,
          ownerId: 3,
          ownerName: 'News Channel',
          ownerProfilePic: 'news.jpg',
          description: 'Breaking: Important announcement from the government regarding new policies...',
          contentType: 5,
          likesCount: 89,
          commentsCount: 56,
          viewsCount: 3400,
          datePosted: DateTime.now().subtract(const Duration(hours: 8)),
        ),
        SocialPost(
          id: 4,
          ownerId: 4,
          ownerName: 'Music Lover',
          ownerProfilePic: 'music.jpg',
          description: 'New track just dropped! 🎵 Listen now',
          imageName: 'audio.mp3',
          contentType: 6,
          likesCount: 67,
          commentsCount: 23,
          datePosted: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      state = state.copyWith(
        posts: samplePosts,
        isLoading: false,
        hasMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshPosts() async {
    state = state.copyWith(posts: [], hasMore: true);
    await loadPosts();
  }

  void toggleLike(int postId) {
    final posts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(
          isLiked: !post.isLiked,
          likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
        );
      }
      return post;
    }).toList();

    state = state.copyWith(posts: posts);
  }
}

final socialFeedProvider =
    StateNotifierProvider<SocialFeedNotifier, SocialFeedState>((ref) {
  return SocialFeedNotifier();
});

// Comments Provider
class CommentsState {
  final List<Comment> comments;
  final bool isLoading;
  final String? errorMessage;

  CommentsState({
    this.comments = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CommentsState copyWith({
    List<Comment>? comments,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class CommentsNotifier extends StateNotifier<CommentsState> {
  final int postId;

  CommentsNotifier(this.postId) : super(CommentsState()) {
    loadComments();
  }

  Future<void> loadComments() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Sample comments
      final sampleComments = [
        Comment(
          id: 1,
          postId: postId,
          userId: 5,
          userName: 'Alice',
          userProfilePic: 'alice.jpg',
          content: 'This is amazing! 👏',
          likesCount: 5,
          datePosted: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        Comment(
          id: 2,
          postId: postId,
          userId: 6,
          userName: 'Bob',
          userProfilePic: 'bob.jpg',
          content: 'Great post, keep it up!',
          likesCount: 3,
          datePosted: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        Comment(
          id: 3,
          postId: postId,
          userId: 7,
          userName: 'Charlie',
          content: 'Love this content ❤️',
          likesCount: 8,
          datePosted: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ];

      state = state.copyWith(
        comments: sampleComments,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> addComment(String content, String userName, String? profilePic) async {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch,
      postId: postId,
      userId: 1,
      userName: userName,
      userProfilePic: profilePic,
      content: content,
      datePosted: DateTime.now(),
    );

    state = state.copyWith(
      comments: [...state.comments, newComment],
    );
  }

  void toggleLike(int commentId) {
    final comments = state.comments.map((comment) {
      if (comment.id == commentId) {
        return comment.copyWith(
          isLiked: !comment.isLiked,
          likesCount: comment.isLiked ? comment.likesCount - 1 : comment.likesCount + 1,
        );
      }
      return comment;
    }).toList();

    state = state.copyWith(comments: comments);
  }
}

final commentsProvider =
    StateNotifierProvider.family<CommentsNotifier, CommentsState, int>((ref, postId) {
  return CommentsNotifier(postId);
});
