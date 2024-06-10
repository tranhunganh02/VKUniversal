import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';

class PostModel extends PostEntity {
  final int userID;
  final String userName;
  final String avatarUrl;
  final String createdAt;
  final String? updateAt;
  final bool likeByUser;
  final int? role;

  PostModel({
    required super.postID,
    super.content,
    super.privacy,
    required super.likes,
    required this.userID,
    this.createdAt = "",
    this.updateAt,
    this.likeByUser = false,
    this.role,
    required this.userName,
    required this.avatarUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postID: json['post_id'] ?? "",
      content: json['content'] ?? "",
      privacy: json['privacy'] ?? false,
      likes: json['like_count'] ?? 0,
      userID: json['user_id'] ?? "",
      createdAt: json['created_at'] ?? "",
      updateAt: json['updated_at'] ?? "",
      role: json['role'] ?? 0,
      likeByUser: json['liked_by_user'] ?? false,
      userName: json['user_name'] ?? '',
      avatarUrl: json['avatar'] ?? '',
    );
  }
}
