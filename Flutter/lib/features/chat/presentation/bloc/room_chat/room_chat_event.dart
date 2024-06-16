part of 'room_chat_bloc.dart';

@immutable
sealed class RoomChatEvent {}

class LoadMessagesEvent extends RoomChatEvent {
  final String idRoom;

  LoadMessagesEvent({
    required this.idRoom,
  });
}

class LoadMessagesNewEvent extends RoomChatEvent {
  final String idRoom;

  LoadMessagesNewEvent({
    required this.idRoom,
  });
}
class SendMessageEvent extends RoomChatEvent {
  final String idRoom;
  final int userId;
  final String message;

  SendMessageEvent({
    required this.idRoom,
    required this.userId,
    required this.message,
  });
}
class UpdateMessagesEvent extends RoomChatEvent {
  final List<MessageModel> messages;

  UpdateMessagesEvent(this.messages);

  @override
  List<Object> get props => [messages];
}

class ClickNavigateEvent extends RoomChatEvent {}
