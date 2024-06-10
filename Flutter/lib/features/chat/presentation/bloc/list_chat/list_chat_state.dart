part of 'list_chat_bloc.dart';

@immutable
sealed class ListChatState {}

class ListChatInitial extends ListChatState {
  ListChatInitial();
}

class ListChatLoading extends ListChatState {}

class ListChatLoaded extends ListChatState {
  final List<RoomChatEntities> listChat;
  final int? userId;
  ListChatLoaded({required this.listChat, required this.userId});
}

final class ListChatError extends ListChatState {
  final String message;
  ListChatError({required this.message});

  List<Object?> get props => [message];
}
