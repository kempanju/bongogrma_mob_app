class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime sentAt;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sentAt,
    this.isRead = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      senderId: json['sender_id'] as int,
      receiverId: json['receiver_id'] as int,
      content: json['content'] as String,
      sentAt: DateTime.parse(json['sent_at'] as String),
      isRead: (json['is_read'] as int?) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'sent_at': sentAt.toIso8601String(),
      'is_read': isRead ? 1 : 0,
    };
  }
}
