import 'package:vkuniversal/features/chat/domain/entities/list_room_chat.dart';
import 'package:vkuniversal/features/chat/domain/repository/list_room_chat_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class FetchListChatUseCase
    implements UseCase<DataState<List<RoomChatEntities>>, void> {
  final RoomChatRepository _roomChatRepository;

  FetchListChatUseCase(this._roomChatRepository);

  @override
  Future<DataState<List<RoomChatEntities>>> call({void data}) {
    return _roomChatRepository.getListChat();
  }
}
