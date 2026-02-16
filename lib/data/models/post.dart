class Post {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? postLink;
  final String? tags;
  final DateTime insertedDate;
  final bool isFavourite;
  final bool isVisible;

  Post({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.postLink,
    this.tags,
    required this.insertedDate,
    this.isFavourite = false,
    this.isVisible = true,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String?,
      postLink: json['post_link'] as String?,
      tags: json['tags'] as String?,
      insertedDate: DateTime.parse(json['inserted_date'] as String),
      isFavourite: (json['favourite'] as int?) == 1,
      isVisible: (json['blog_visible'] as int?) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'post_link': postLink,
      'tags': tags,
      'inserted_date': insertedDate.toIso8601String(),
      'favourite': isFavourite ? 1 : 0,
      'blog_visible': isVisible ? 1 : 0,
    };
  }

  Post copyWith({
    int? id,
    String? title,
    String? content,
    String? imageUrl,
    String? postLink,
    String? tags,
    DateTime? insertedDate,
    bool? isFavourite,
    bool? isVisible,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      postLink: postLink ?? this.postLink,
      tags: tags ?? this.tags,
      insertedDate: insertedDate ?? this.insertedDate,
      isFavourite: isFavourite ?? this.isFavourite,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
