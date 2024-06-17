part of 'newfeed_bloc.dart';

@immutable
sealed class NewfeedState {}

final class NewfeedInitial extends NewfeedState {}

final class NewfeedLoading extends NewfeedState {}

final class NewfeedLoaded extends NewfeedState {
  final List<PostModel> posts;
  List<CommentModel> comments;
  NewfeedLoaded({
    required this.posts,
    this.comments = const [],
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
