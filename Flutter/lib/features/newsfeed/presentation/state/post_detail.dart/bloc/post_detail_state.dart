part of 'post_detail_bloc.dart';

@immutable
sealed class PostDetailState {}

final class PostDetailInitial extends PostDetailState {}

final class PostDetailLoading extends PostDetailState {}

final class PostDetailLoaded extends PostDetailState {
  final PostModel post;
  final List<CommentModel> comments;
  PostDetailLoaded({
    required this.post,
    required this.comments,
  });
}

final class PostDetailFailed extends PostDetailState {}
