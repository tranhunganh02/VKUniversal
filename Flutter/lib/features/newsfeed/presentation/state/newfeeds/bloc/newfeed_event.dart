part of 'newfeed_bloc.dart';

@immutable
sealed class NewfeedEvent {}

final class LoadPosts extends NewfeedEvent {
  final int page;
  LoadPosts({required this.page});
}

final class LikePressed extends NewfeedEvent {
  final bool isLiked;
  final int postID;

  LikePressed({
    required this.isLiked,
    required this.postID,
  });
}

final class LoadMorePosts extends NewfeedEvent {
  final int page;

  LoadMorePosts({required this.page});
}

class LoadPostDetail extends NewfeedEvent {
  final int postID;
  LoadPostDetail({required this.postID});
}
