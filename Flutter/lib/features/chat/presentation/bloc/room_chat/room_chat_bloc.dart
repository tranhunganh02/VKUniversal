import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../data/data_source/firebase/chat_service.g.dart';
import '../../../data/model/message.dart';
import '../../../domain/usecase/fetch_messages.dart';

part 'room_chat_event.dart';
part 'room_chat_state.dart';

class RoomChatBloc extends Bloc<RoomChatEvent, RoomChatState> {
  final FirebaseChatService _firebaseChatService;
 StreamSubscription<List<MessageModel>>? _messagesSubscription;
  RoomChatBloc(this._firebaseChatService) : super(ChatInitial()) {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(ChatLoadingState());
    on<RoomChatEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadMessagesEvent>(
      (event, emit) async {
        try {
          emit(ChatLoadingState());
          print("cos goi");
           await _messagesSubscription?.cancel();
         _messagesSubscription = _firebaseChatService.getMessages(event.idRoom).listen(
        (messages) {
          add(UpdateMessagesEvent(messages));
        },
        onError: (error) {
          emit(ChatErrorState(message: error.toString()));
        },
      );
        } catch (error) {
          emit(ChatErrorState(
              message: error.toString())); // Handle error more comprehensively
        }
      },
    );
        on<UpdateMessagesEvent>((event, emit) {
      emit(ChatLoadedState(messages: event.messages));
    });
    on<SendMessageEvent>(
      (event, emit) async {
        try {
          await _firebaseChatService.sendMessage(
              event.idRoom, event.userId, event.message);
        } catch (error) {
          emit(ChatErrorState(
              message: error.toString())); // Handle error more comprehensively
        }
      },
    );

  }
}
