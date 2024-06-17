part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

class CreateCommentSuccess extends CommentState {}

class CreateCommentFailed extends CommentState {}
