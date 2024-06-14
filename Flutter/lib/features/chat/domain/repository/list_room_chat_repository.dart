import 'package:vkuniversal/features/chat/domain/entities/list_room_chat.dart';

import '../../../../core/resources/data_state.dart';

abstract interface class RoomChatRepository {
  Future<DataState<List<RoomChatEntities>>> getListChat();
}
