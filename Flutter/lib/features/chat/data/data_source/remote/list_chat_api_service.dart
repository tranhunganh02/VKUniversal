import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/features/chat/data/model/list_room_chat.dart';

part 'list_chat_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrlIos)
abstract class RoomChatService {
  factory RoomChatService(Dio dio) = _RoomChatService;
  @GET('/chat')
  Future<HttpResponse<List<RoomChatModel>>> getListChat(
    @Header('authorization') String? token,
    @Header('x-client-id') int? userId,
  );
}
