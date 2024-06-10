part of 'list_chat_bloc.dart';

@immutable
sealed class ListChatEvent {}

class ListChatInitialEvent extends ListChatEvent {}

class GetListChatEvent extends ListChatEvent {
  GetListChatEvent();
}

class ListChatItemNavigateEvent extends ListChatEvent {}
