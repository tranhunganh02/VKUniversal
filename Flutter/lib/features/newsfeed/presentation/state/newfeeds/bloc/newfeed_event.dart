part of 'newfeed_bloc.dart';

@immutable
sealed class NewfeedEvent {}

final class LoadPosts extends NewfeedEvent {
  final int page;
  LoadPosts({required this.page});
}
