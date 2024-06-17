import 'package:vkuniversal/features/newsfeed/domain/entities/comment.dart';

class CommentModel extends CommentEntity {
  final String userName;
  final String avatar;
  CommentModel({
    required super.commentID,
    required super.postID,
    required super.userID,
    required super.prID,
    required super.content,
    required this.userName,
    required this.avatar,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentID: json['comment_id'],
      postID: json['post_id'],
      userID: json['user_id'] ?? 0,
      prID: json['pr_id'],
      content: json['content'],
      userName: json['user_name'] ?? "Anonymous",
      avatar: json['avatar'] ?? "",
    );
  }
}
