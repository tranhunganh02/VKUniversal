import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int postID;
  final String? content;
  final bool privacy;
  final int likes;

  PostEntity({
    required this.postID,
    this.content,
    this.privacy = false,
    required this.likes,
  });

  @override
  List<Object?> get props => [postID];
}
