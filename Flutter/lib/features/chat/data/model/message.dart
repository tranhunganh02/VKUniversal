import 'dart:io';

import 'package:vkuniversal/features/chat/domain/entities/message.dart';

class MessageModel extends MessageEnitites {
  MessageModel({
    required String idMessage,
    required int userId,
    required String message,
    File? file,
  }) : super(
            idMessage: idMessage, userId: userId, message: message, file: file);

  factory MessageModel.fromSnapshot(Map<String, dynamic> snapshot, String id) {
    final userId = snapshot[
        'idUser']; // Assuming either 'idUser' or 'id' contains the user ID
    final message = snapshot['message'];
    final file = snapshot['file'];
    final idMessage = id;
    return MessageModel(
      idMessage: idMessage,
      userId: userId,
      message: message,
      file: file != null
          ? File(file)
          : null, // Assuming 'file' is a file path or null
    );
  }

  Map<String, dynamic> toMapWithoutFile() {
    return {
      idMessage: {'userId': userId, 'message': message}
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
      'file': file,
    };
  }
}
