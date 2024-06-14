import 'package:vkuniversal/features/newsfeed/data/model/attachment.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';

class PostModel extends PostEntity {
  final int userID;
  final String userName;
  final String avatarUrl;
  final String createdAt;
  final String? updateAt;
  final bool likeByUser;
  final int? role;
  final List<Attachment>? images;

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
    required this.images,
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
      images: (json['image_urls'] as List<dynamic>?)
          ?.map((imageJson) => Attachment.fromJson(imageJson))
          .toList(),
    );
  }

  PostModel copyWith({
    int? userID,
    String? userName,
    String? avatarUrl,
    String? createdAt,
    String? updateAt,
    bool? likeByUser,
    int? role,
    int? likes,
    List<Attachment>? images,
  }) {
    return PostModel(
      userID: userID ?? this.userID,
      postID: postID,
      userName: userName ?? this.userName,
      createdAt: createdAt ?? this.createdAt,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      images: images ?? this.images,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      likeByUser: likeByUser ?? this.likeByUser,
    );
  }
}
