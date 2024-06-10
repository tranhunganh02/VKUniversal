import 'package:equatable/equatable.dart';

class RoomChatEntities extends Equatable {
  final String? lastMessage;
  final List<int>? users;
  final int? createAt;
  final String? documentId;
  final String? avatar;
  final String? username;

  RoomChatEntities( {
    this.username,
    this.lastMessage,
    this.users,
    this.createAt,
    this.documentId,
    this.avatar,
  });

  @override
  List<Object?> get props => [username, lastMessage, users, createAt, documentId, avatar];
}
