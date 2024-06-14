part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostEvent {}

final class SubmitPost extends CreatePostEvent {
  final String content;
  final List<File> images;

  SubmitPost({required this.content, required this.images});
}
