part of 'post_detail_bloc.dart';

@immutable
sealed class PostDetailEvent {}
class LoadPostDetail extends PostDetailEvent {
  final int postID;
  LoadPostDetail({required this.postID});
}

