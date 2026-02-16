import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post.dart';

class PostsState {
  final List<Post> posts;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final bool hasMore;

  PostsState({
    this.posts = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.hasMore = true,
  });

  PostsState copyWith({
    List<Post>? posts,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    bool? hasMore,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class PostsNotifier extends StateNotifier<PostsState> {
  final Ref ref;

  PostsNotifier(this.ref) : super(PostsState()) {
    loadPosts();
  }

  Future<void> loadPosts({bool refresh = false}) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, hasError: false);

    try {
      // Simulated API call - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Sample data for demonstration
      final samplePosts = List.generate(
        10,
        (index) => Post(
          id: index + 1,
          title: 'Sample News Article ${index + 1}',
          content: '<p>This is the content of article ${index + 1}. It contains important news and updates.</p>',
          imageUrl: 'https://picsum.photos/seed/${index + 1}/400/300',
          insertedDate: DateTime.now().subtract(Duration(hours: index * 2)),
          postLink: 'https://example.com/article/${index + 1}',
        ),
      );

      state = state.copyWith(
        posts: refresh ? samplePosts : [...state.posts, ...samplePosts],
        isLoading: false,
        hasMore: samplePosts.length >= 10,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = PostsState();
    await loadPosts(refresh: true);
  }

  void toggleFavourite(int postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(isFavourite: !post.isFavourite);
      }
      return post;
    }).toList();

    state = state.copyWith(posts: updatedPosts);
  }
}

final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  return PostsNotifier(ref);
});
