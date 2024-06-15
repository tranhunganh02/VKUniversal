import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/chat/data/model/page_request.dart';
import 'package:vkuniversal/features/chat/domain/entities/list_room_chat.dart';
import 'package:vkuniversal/features/chat/domain/repository/list_room_chat_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class FetchListChatUseCase
    implements UseCase<DataState<List<RoomChatEntities>>, PageRequest> {
  final RoomChatRepository _roomChatRepository;

  FetchListChatUseCase({required RoomChatRepository roomChatRepository})
      : _roomChatRepository = roomChatRepository;

  @override
  Future<DataState<List<RoomChatEntities>>> call(
      {PageRequest? data, Authorization? auth}) {
    return _roomChatRepository.getListChat(
        userID: auth!.userID, accessToken: auth.accessToken, page: data!);
  }
}
