import 'package:vkuniversal/features/chat/domain/entities/list_room_chat.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/model/page_request.dart';

abstract class RoomChatRepository {
  Future<DataState<List<RoomChatEntities>>> getListChat({
    required int userID,
    required String accessToken,
    required PageRequest page,
  });
}
