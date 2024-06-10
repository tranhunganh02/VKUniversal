import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_posts.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';
import 'package:vkuniversal/features/profile/domain/usecase/load_profile.dart';

part 'newfeed_event.dart';
part 'newfeed_state.dart';

class NewfeedBloc extends Bloc<NewfeedEvent, NewfeedState> {
  final GetPosts _getPosts;
  NewfeedBloc(this._getPosts) : super(NewfeedInitial()) {
    on<LoadPosts>((event, emit) async {
      emit(NewfeedLoading());
      try {
        SharedPreferences _pref = await SharedPreferences.getInstance();
        final response = await _getPosts(
            auth: SetUpAuthData(_pref), data: PageRequest(page: event.page));

        if (response is DataSuccess) {
          logger.d("Response Data: ${response.data}");

          emit(NewfeedLoaded(posts: response.data as List<PostModel>));
        } else {
          emit(NewfeedFailed(message: "Error: Data is null"));
        }
      } catch (e) {}
    });
  }
}
