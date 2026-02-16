class SocialPost {
  final int id;
  final int ownerId;
  final String ownerName;
  final String? ownerProfilePic;
  final String? description;
  final String? imageName;
  final String? videoThumb;
  final int contentType; // 0=text, 1=image, 2=video, 4=pdf, 5=news, 6=audio
  final int likesCount;
  final int commentsCount;
  final int viewsCount;
  final bool isLiked;
  final bool isFree;
  final int? amount;
  final int? videoDuration;
  final int? videoSize;
  final DateTime datePosted;

  SocialPost({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    this.ownerProfilePic,
    this.description,
    this.imageName,
    this.videoThumb,
    this.contentType = 0,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.viewsCount = 0,
    this.isLiked = false,
    this.isFree = true,
    this.amount,
    this.videoDuration,
    this.videoSize,
    required this.datePosted,
  });

  factory SocialPost.fromJson(Map<String, dynamic> json) {
    return SocialPost(
      id: json['id'] as int,
      ownerId: json['owner_id'] as int,
      ownerName: json['owner_name'] as String? ?? 'Unknown',
      ownerProfilePic: json['profile_pic'] as String?,
      description: json['description'] as String?,
      imageName: json['image_name'] as String?,
      videoThumb: json['video_thumb'] as String?,
      contentType: json['content_type'] as int? ?? 0,
      likesCount: json['likes_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
      viewsCount: json['views_count'] as int? ?? 0,
      isLiked: (json['is_liked'] as int? ?? 0) == 1,
      isFree: (json['is_free'] as int? ?? 1) == 1,
      amount: json['amount'] as int?,
      videoDuration: json['video_duration'] as int?,
      videoSize: json['video_size'] as int?,
      datePosted: DateTime.tryParse(json['date_posted'] as String? ?? '') ?? DateTime.now(),
    );
  }

  SocialPost copyWith({
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
  }) {
    return SocialPost(
      id: id,
      ownerId: ownerId,
      ownerName: ownerName,
      ownerProfilePic: ownerProfilePic,
      description: description,
      imageName: imageName,
      videoThumb: videoThumb,
      contentType: contentType,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      viewsCount: viewsCount,
      isLiked: isLiked ?? this.isLiked,
      isFree: isFree,
      amount: amount,
      videoDuration: videoDuration,
      videoSize: videoSize,
      datePosted: datePosted,
    );
  }

  String get contentTypeLabel {
    switch (contentType) {
      case 0:
        return 'Text';
      case 1:
        return 'Image';
      case 2:
        return 'Video';
      case 4:
        return 'PDF';
      case 5:
        return 'News';
      case 6:
        return 'Audio';
      default:
        return 'Post';
    }
  }

  bool get isVideo => contentType == 2;
  bool get isAudio => contentType == 6;
  bool get isImage => contentType == 1;
  bool get isText => contentType == 0;
}

class Comment {
  final int id;
  final int postId;
  final int userId;
  final String userName;
  final String? userProfilePic;
  final String content;
  final int likesCount;
  final bool isLiked;
  final DateTime datePosted;
  final List<Comment>? replies;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    this.userProfilePic,
    required this.content,
    this.likesCount = 0,
    this.isLiked = false,
    required this.datePosted,
    this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      postId: json['post_id'] as int? ?? 0,
      userId: json['user_id'] as int,
      userName: json['user_name'] as String? ?? 'Unknown',
      userProfilePic: json['profile_pic'] as String?,
      content: json['content'] as String? ?? '',
      likesCount: json['likes_count'] as int? ?? 0,
      isLiked: (json['is_liked'] as int? ?? 0) == 1,
      datePosted: DateTime.tryParse(json['date_posted'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Comment copyWith({
    int? likesCount,
    bool? isLiked,
  }) {
    return Comment(
      id: id,
      postId: postId,
      userId: userId,
      userName: userName,
      userProfilePic: userProfilePic,
      content: content,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      datePosted: datePosted,
      replies: replies,
    );
  }
}
