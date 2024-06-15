part of 'newfeed_bloc.dart';

@immutable
sealed class NewfeedState {}

final class NewfeedInitial extends NewfeedState {}

final class NewfeedLoading extends NewfeedState {}

final class NewfeedLoaded extends NewfeedState {
  final List<PostModel> posts;
  NewfeedLoaded({
    required this.posts,
  });
}

final class NewfeedFailed extends NewfeedState {
  final String message;
  NewfeedFailed({required this.message});
}

final class LikedByUser extends NewfeedState {}

final class UnLikedByUser extends NewfeedState {}

class PostDetailLoaded extends NewfeedState {
  final PostModel post;

  PostDetailLoaded({required this.post});
}
