part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostState {}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostLoading extends CreatePostState {}

final class CreatePostSuccess extends CreatePostState {}

final class CreatePostFailed extends CreatePostState {
  final String message;

  CreatePostFailed({required this.message});
}
