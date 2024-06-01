import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';

class PostModel extends PostEntity {
  final UserModel user;

  PostModel({
    required super.post_id,
    super.content,
    super.privacy,
    required super.likes,
    required this.user,
  });
}
