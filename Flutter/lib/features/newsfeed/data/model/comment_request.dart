class CommentRequest {
  final int postID;
  final String content;

  CommentRequest({required this.postID, required this.content});
  Map<String, dynamic> toJson() {
    return {'post_id': postID, 'content': content};
  }
}
