// ignore_for_file: unused_import

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/chat/data/data_source/remote/list_chat_api_service.dart';
import 'package:vkuniversal/features/chat/domain/entities/list_room_chat.dart';
import 'package:vkuniversal/features/chat/domain/repository/list_room_chat_repository.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/refresh_token.dart';
import '../../../../core/constants/share_pref.dart';
import '../../../auth/data/models/authorization.dart';
import '../../../auth/domain/usecases/refresh_token.dart';
import '../model/page_request.dart';

class RoomChatRepositoryImpl implements RoomChatRepository {
  final RoomChatService _roomChatService;
  Logger _logger = Logger();
  RoomChatRepositoryImpl({required RoomChatService roomChatService})
      : _roomChatService = roomChatService;
  @override
  Future<DataState<List<RoomChatEntities>>> getListChat({
        required int userID,
    required String accessToken,
    required PageRequest page,
  }) async {
    try {
      final _prefs = await SharedPreferences.getInstance();

      Authorization authorization = SetUpAuthData(_prefs);

      final response = await _roomChatService.getListChat(
        authorization.accessToken,
        authorization.userID,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        logger.d("Get Profile Data Successfully");
        return DataSuccess(response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RefreshToken(authRepository: sl());
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        return await getListChat(
            userID: authorization.userID,
            accessToken: authorization.accessToken,
            page: page);
      } else if (response.response.statusCode == 404) {
        logger.d("Loi 404");
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
      RequestOptions options = RequestOptions();
      return DataFailed(DioException(requestOptions: options));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
