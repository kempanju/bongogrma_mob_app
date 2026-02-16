import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/social_post.dart';

class Tag {
  final String name;
  final int postCount;
  final bool isTrending;

  Tag({
    required this.name,
    this.postCount = 0,
    this.isTrending = false,
  });
}

class TagsState {
  final List<Tag> trendingTags;
  final List<SocialPost> tagPosts;
  final String? selectedTag;
  final bool isLoading;
  final String? errorMessage;

  TagsState({
    this.trendingTags = const [],
    this.tagPosts = const [],
    this.selectedTag,
    this.isLoading = false,
    this.errorMessage,
  });

  TagsState copyWith({
    List<Tag>? trendingTags,
    List<SocialPost>? tagPosts,
    String? selectedTag,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TagsState(
      trendingTags: trendingTags ?? this.trendingTags,
      tagPosts: tagPosts ?? this.tagPosts,
      selectedTag: selectedTag ?? this.selectedTag,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class TagsNotifier extends StateNotifier<TagsState> {
  TagsNotifier() : super(TagsState()) {
    loadTrendingTags();
  }

  Future<void> loadTrendingTags() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final sampleTags = [
        Tag(name: '#Tanzania', postCount: 1250, isTrending: true),
        Tag(name: '#DarEsSalaam', postCount: 890, isTrending: true),
        Tag(name: '#Football', postCount: 756, isTrending: true),
        Tag(name: '#Music', postCount: 654, isTrending: true),
        Tag(name: '#Politics', postCount: 543, isTrending: true),
        Tag(name: '#Entertainment', postCount: 432, isTrending: false),
        Tag(name: '#Sports', postCount: 321, isTrending: false),
        Tag(name: '#Technology', postCount: 234, isTrending: false),
        Tag(name: '#Business', postCount: 198, isTrending: false),
        Tag(name: '#Health', postCount: 156, isTrending: false),
      ];

      state = state.copyWith(
        trendingTags: sampleTags,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadPostsByTag(String tag) async {
    state = state.copyWith(isLoading: true, selectedTag: tag);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Sample posts for the tag
      final samplePosts = List.generate(
        5,
        (index) => SocialPost(
          id: index + 100,
          ownerId: index + 1,
          ownerName: 'User ${index + 1}',
          description: 'Post about $tag - This is sample content #${index + 1}',
          imageName: 'sample_$index.jpg',
          contentType: index % 2 == 0 ? 1 : 0,
          likesCount: (index + 1) * 15,
          commentsCount: (index + 1) * 3,
          datePosted: DateTime.now().subtract(Duration(hours: index * 2)),
        ),
      );

      state = state.copyWith(
        tagPosts: samplePosts,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clearSelectedTag() {
    state = state.copyWith(selectedTag: null, tagPosts: []);
  }
}

final tagsProvider = StateNotifierProvider<TagsNotifier, TagsState>((ref) {
  return TagsNotifier();
});
