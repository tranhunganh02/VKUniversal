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

class LoadOldMessagesEvent extends RoomChatEvent {
  final String idRoom;
  final String idMessage;
  final int userId;
  final String message;
  LoadOldMessagesEvent(
      {required this.idRoom,
      required this.idMessage,
      required this.userId,
      required this.message});
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

class ClickNavigateEvent extends RoomChatEvent {}
