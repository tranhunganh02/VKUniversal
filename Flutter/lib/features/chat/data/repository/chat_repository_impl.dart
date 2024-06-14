import 'package:firebase_database/firebase_database.dart';
import 'package:vkuniversal/features/chat/domain/entities/message.dart';

import '../../domain/repository/chat_repository.dart';
import '../data_source/firebase/chat_service.g.dart';
import 'package:logger/logger.dart';

class FirebaseChatRepositoryImpl implements ChatRepository {
  final FirebaseChatService _chatService;
  Logger _logger = Logger();
  FirebaseChatRepositoryImpl(this._chatService);

  @override
  Stream<List<MessageEnitites>> loadMessages(String idRoom) {
    return _chatService.getMessages(idRoom);
  }

  @override
  Future<void> sendMessage(int idRoom, String message, int userId) async {
    // TODO: implement sendMessage
  }
}
