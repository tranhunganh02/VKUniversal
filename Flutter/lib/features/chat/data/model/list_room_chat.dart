import 'package:vkuniversal/features/chat/domain/entities/list_room_chat.dart';

class RoomChatModel extends RoomChatEntities {
  RoomChatModel({
    super.lastMessage,
    super.users,
    super.createAt,
     super.timeLastMessage,
    super.documentId,
    super.avatar,
    super.username
  });
  factory RoomChatModel.fromJson(Map<String, dynamic> json) {
    return RoomChatModel(
      lastMessage: json['last_message'] as String?,
      users: List<int>.from(json['users']),
      createAt: json['create_at'] as int,
      timeLastMessage: json['time_last_message'] as int?,
      documentId: json['document_id'] as String,
      avatar: json['avatar'] as String?,
      username: json['username'] as String?,
    );
  }

  // Method to convert RoomChat instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'last_message': lastMessage,
      'users': users,
      'create_at': createAt,
      'avatar': avatar,
       'username': username,
    };
  }
}
