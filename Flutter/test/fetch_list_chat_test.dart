import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/features/chat/data/data_source/remote/list_chat_api_service.dart';

void main() {
  group("description", () { 
        test("Test fetch list chat", () async {
      final dio = Dio();
      Logger _logger = Logger();
      final listChatService = RoomChatService(dio);

      int id = 18;
      String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE4LCJlbWFpbCI6Imh0c2FuZy50Z0B2a3UudWRuLnZuIiwicm9sZSI6MSwiaWF0IjoxNzE3MjY5ODczLCJleHAiOjE3MTcyODYwNzN9.XxR0IRrhqSfaR6g4pwkFU-djmJXjZFm6RBGSjkr7USQ';

      final response = await listChatService.getListChat(token, id);
    
    _logger.d(response.data);
      _logger.d(response.response.statusMessage);

      expect(response.response.statusCode, HttpStatus.ok);
    });
    

  });
}
