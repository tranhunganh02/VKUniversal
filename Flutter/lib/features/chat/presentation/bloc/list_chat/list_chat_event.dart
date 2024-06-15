part of 'list_chat_bloc.dart';

@immutable
sealed class ListChatEvent {}

class ListChatInitialEvent extends ListChatEvent {}

class GetListChatEvent extends ListChatEvent {
    final int page;
  GetListChatEvent({required this.page});
}

class ListChatItemNavigateEvent extends ListChatEvent {}
