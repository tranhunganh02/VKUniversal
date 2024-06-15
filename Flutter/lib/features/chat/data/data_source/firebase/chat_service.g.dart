import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:vkuniversal/features/chat/presentation/pages/data_fake.dart';

import '../../model/message.dart';

class FirebaseChatService {
 Stream<List<MessageModel>> getMessages(String idRoom) {
    var controller = StreamController<List<MessageModel>>.broadcast();
    Query ref = FirebaseDatabase.instance.ref('ChatRoom/$idRoom').orderByKey();

    ref.onValue.listen((event) {
      final data = event.snapshot.value;

      if (data == null) {
        controller.add(<MessageModel>[]); // Return an empty list if data is null
      } else if (data is Map<dynamic, dynamic>) {
        var messages = data.entries.map((entry) {
          var entryValue = entry.value as Map<dynamic, dynamic>;
          return MessageModel(
            idMessage: entry.key,
            userId: entryValue['idUser'] as int,
            message: entryValue['message'] as String,
          );
        }).toList();
        messages.sort((a, b) => a.idMessage.compareTo(b.idMessage));
        controller.add(messages); // Add the list of MessageModels to the stream
      } else {
        controller.add(<MessageModel>[]); // Handle unexpected data types
      }
    });
    return controller.stream;
  }

  Stream<List<MessageModel>> getOldMessages(
      String idRoom, String lastMessageId) {
    var controller = StreamController<List<MessageModel>>.broadcast();
    Query ref = FirebaseDatabase.instance
        .ref('ChatRoom/$idRoom')
        .orderByKey()
        .endBefore(lastMessageId)
        .limitToLast(10);

    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;

      if (data == null) {
        controller.add(<MessageModel>[]);
      } else {
        var messages = data.entries
            .map((entry) => MessageModel(
                  idMessage: entry.key,
                  userId: entry.value['idUser'] as int,
                  message: entry.value['message'] as String,
                ))
            .toList();
        messages.sort((a, b) => a.idMessage.compareTo(b.idMessage));
        controller.add(messages);
      }
    });
    return controller.stream;
  }

  Future<void> sendMessage(String idRoom, int userId, String message) async {
    // Get a reference to the specific message location in the chat room
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // Get a reference to the specific message location in the chat room with the timestamp as the key
    final ref = FirebaseDatabase.instance.ref('ChatRoom/$idRoom/$timestamp');

    // Create a map containing message details
    final messageData = {
      'idUser': userId,
      'message': message,
    };

    // Set the message data at the generated reference location
    await ref.set(messageData);
  }
}
