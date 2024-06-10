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

  RoomChatBloc(this._firebaseChatService) : super(ChatInitial()) {
    emit(ChatLoadingState());
    on<RoomChatEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadMessagesEvent>(
      (event, emit) async {
        try {
          emit(ChatLoadingState());
          print("cos goi");
          final data =
              await _firebaseChatService.getMessages(event.idRoom).first;
          emit(ChatLoadedState(messages: data));
        } catch (error) {
          emit(ChatErrorState(
              message: error.toString())); // Handle error more comprehensively
        }
      },
    );

    on<LoadMessagesNewEvent>(
      (event, emit) async {
        emit(ChatLoadingState());
        try {
          print("cos goi");
          final data =
              await _firebaseChatService.getMessages(event.idRoom).first;
          emit(ChatLoadedState(messages: data));
        } catch (error) {
          emit(ChatErrorState(
              message: error.toString())); // Handle error more comprehensively
        }
      },
    );
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
    on<LoadOldMessagesEvent>((event, emit) async {
      try {
        print("Loading old messages2");
        final oldMessages = await _firebaseChatService
            .getOldMessages(
              event.idRoom,
              event.idMessage,
            )
            .first;

        final currentState = state as ChatLoadedState;
        final allMessages = [...oldMessages, ...currentState.messages];
        emit(ChatLoadedState(
          messages: allMessages,
        ));
      } catch (error) {
        emit(ChatErrorState(
          message: error.toString(),
        ));
      }
    });
  }
}
