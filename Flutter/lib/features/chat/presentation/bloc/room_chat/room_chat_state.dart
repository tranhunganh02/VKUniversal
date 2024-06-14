part of 'room_chat_bloc.dart';

@immutable
sealed class RoomChatState extends Equatable {}

final class ChatInitial extends RoomChatState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class ChatFirstData extends RoomChatState {
  final MessageModel message;

  ChatFirstData(this.message);
  // TODO: implement props
  List<Object?> get props => [message];
}

final class ChatLoadingState extends RoomChatState {
  @override
  // TODO: implement props
  List<Object?> get props => [null];
}

class ChatLoadedState extends RoomChatState {
  final List<MessageModel> messages;

  ChatLoadedState({required this.messages});

  @override
  // TODO: implement props
  List<Object?> get props => [messages];
}

final class ChatErrorState extends RoomChatState {
  final String message;

  ChatErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
