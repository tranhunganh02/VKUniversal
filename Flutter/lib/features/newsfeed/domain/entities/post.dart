import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int post_id;
  final String? content;
  final bool privacy;
  final int likes;

  PostEntity({
    required this.post_id,
    this.content,
    this.privacy = true,
    required this.likes,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
