class PostRequest {
  final int postID;

  PostRequest({required this.postID});

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return PostRequest(
      postID: json['post_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'post_id': postID,
    };
  }
}
