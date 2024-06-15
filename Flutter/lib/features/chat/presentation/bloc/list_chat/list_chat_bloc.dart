
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/features/chat/data/model/page_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../domain/entities/list_room_chat.dart';
import '../../../domain/usecase/fetch_list_chat.dart';

part 'list_chat_event.dart';
part 'list_chat_state.dart';

class ListChatBloc extends Bloc<ListChatEvent, ListChatState> {
  final FetchListChatUseCase _fetchListChatUseCase;

  ListChatBloc(this._fetchListChatUseCase) : super(ListChatLoading()) {
    on<GetListChatEvent>(getListChat);
  }

  void getListChat(event, emit) async {
    Logger _logger = Logger();
    try {
       SharedPreferences _pref = await SharedPreferences.getInstance();
      
      final response = await _fetchListChatUseCase(
          auth: SetUpAuthData(_pref), data: PageRequest(page: event.page)
      );
      if (response is DataSuccess  && response.data!.isNotEmpty) {
          _logger.d("API Response: ${response.data}");
           SharedPreferences prefs = await SharedPreferences.getInstance();
           int? id = prefs.getInt('userID');
          emit(
            ListChatLoaded(listChat: response.data!, userId: id),
          );
      } 
      if (response is DataFailed) {
        emit(ListChatError(message: response.error!.message.toString()));
      }
    } on DioException catch (e) {
      emit(ListChatError(message: e.toString()));
    }
  }
}
