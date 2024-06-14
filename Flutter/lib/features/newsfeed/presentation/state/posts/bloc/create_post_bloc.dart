import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/create_post.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePost _createPost;
  CreatePostBloc(this._createPost) : super(CreatePostInitial()) {
    on<SubmitPost>((event, emit) async {
      emit(CreatePostLoading());
      try {
        final data = CreatePostRequest(
            content: event.content,
            privacy: false,
            postType: 1,
            attachments: event.images);
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        final response = await _createPost(auth: authorization, data: data);
        if (response is DataSuccess) {
          emit(CreatePostSuccess());
        } else {
          logger.e("Error: ${response.error}");
          emit(CreatePostFailed(message: "Error: Data is null!"));
        }
      } catch (e) {
        logger.e("Error: ${e}");
        emit(CreatePostFailed(message: "Error: Data is null"));
      }
    });
  }
}
