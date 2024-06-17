part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class CreateComment extends CommentEvent {
  final int postID;
  final String content;
  CreateComment({required this.postID, required this.content});
}