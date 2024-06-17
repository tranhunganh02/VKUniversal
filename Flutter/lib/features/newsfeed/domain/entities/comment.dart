import 'dart:core';


class CommentEntity {
  final String commentID;
  final int postID;
  final int userID;
  final String? prID;
  final String content;

  CommentEntity({
    required this.commentID,
    required this.postID,
    required this.userID,
    required this.prID,
    required this.content,
  });

  @override
  String toString() {
    return 'CommentEntity(commentID: $commentID, postID: $postID, userID: $userID, prID: $prID, content: $content)';
  }
}
