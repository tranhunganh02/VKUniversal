import 'package:vkuniversal/features/chat/domain/entities/message.dart';

abstract interface class ChatRepository {
  
  Stream<List<MessageEnitites>> loadMessages(String idRoom);

  Future<void> sendMessage(int idRoom, String message, int userId);
}
