import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/comment.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_comments.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_post_by_id.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_posts.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/like.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/unlike.dart';

part 'newfeed_event.dart';
part 'newfeed_state.dart';

class NewfeedBloc extends Bloc<NewfeedEvent, NewfeedState> {
  final GetPosts _getPosts;
  NewfeedBloc(this._getPosts) : super(NewfeedInitial()) {
    final _likeAPost = sl<LikeAPost>();
    final _unLikePost = sl<Unlike>();
    on<LoadPosts>((event, emit) async {
      emit(NewfeedLoading());
      try {
        SharedPreferences _pref = await SharedPreferences.getInstance();
        final response = await _getPosts(
            auth: SetUpAuthData(_pref), data: PageRequest(page: event.page));

        if (response is DataSuccess) {
          logger.d("Response Data: ${response.data}");
          final data = response.data as List<PostModel>;
          for (int i = 0; i < data.length; i++) {
            logger.d("Response Data: ${data[i].images}");
          }
          emit(NewfeedLoaded(posts: response.data as List<PostModel>));
        } else {
          emit(NewfeedFailed(message: "Error: Data is null"));
        }
      } catch (e) {
        emit(NewfeedFailed(message: "Error: Data is null"));
      }
    });
    on<LikePressed>(
      (event, emit) async {
        if (state is NewfeedLoaded) {
          final currentState = state as NewfeedLoaded;
          if (event.isLiked) {
            final postRequest = PostRequest(postID: event.postID);
            SharedPreferences _pref = await SharedPreferences.getInstance();
            Authorization authorization = SetUpAuthData(_pref);
            final respose = await _unLikePost(
              data: postRequest,
              auth: authorization,
            );
            if (respose is DataSuccess) {
              logger.d(respose);
            }
            final updatePost = currentState.posts.map((post) {
              if (post.postID == event.postID) {
                return post.copyWith(likeByUser: false, likes: post.likes - 1);
              }
              return post;
            }).toList();
            emit(NewfeedLoaded(posts: updatePost));
          } else {
            final postRequest = PostRequest(postID: event.postID);
            SharedPreferences _pref = await SharedPreferences.getInstance();
            Authorization authorization = SetUpAuthData(_pref);
            final respose = await _likeAPost(
              data: postRequest,
              auth: authorization,
            );

            if (respose is DataSuccess) {
              logger.d(respose);
            }
            final updatePost = currentState.posts.map((post) {
              if (post.postID == event.postID) {
                return post.copyWith(likeByUser: true, likes: post.likes + 1);
              }
              return post;
            }).toList();
            emit(NewfeedLoaded(posts: updatePost));
          }
        }
      },
    );
    on<LoadMorePosts>((event, emit) async {
      try {
        final currentState = state;
        if (currentState is NewfeedLoaded) {
          SharedPreferences _pref = await SharedPreferences.getInstance();
          final response = await _getPosts(
              auth: SetUpAuthData(_pref), data: PageRequest(page: event.page));

          if (response is DataSuccess) {
            final data = response.data as List<PostModel>;
            final updatePost = currentState.posts..addAll(data);
            emit(NewfeedLoaded(posts: updatePost));
          } else {
            // emit(NewfeedFailed(message: "Error: Data is null"));
          }
        }
      } catch (e) {
        // emit(NewfeedFailed(message: "Error: $e"));
      }
    });
    on<LoadPostDetail>((event, emit) async {
      final _getPostByID = sl<GetPostById>();
      final _getComments = sl<GetComments>();

      if (state is NewfeedInitial) {
        emit(NewfeedLoading());
        try {
          logger.d("At comment");
          SharedPreferences pref = await SharedPreferences.getInstance();
          Authorization authorization = SetUpAuthData(pref);

          final response = await _getPostByID(
              auth: authorization, data: PostRequest(postID: event.postID));

          final commentResponse = await _getComments(
            auth: authorization,
            data: PostRequest(postID: event.postID),
          );

          if (response is DataSuccess && commentResponse is DataSuccess) {
            final post = response.data as List<PostModel>;
            final comments = commentResponse.data as List<CommentModel>;
            logger.d("At comment: ${comments.length}");

            emit(NewfeedLoaded(posts: post, comments: comments));
          } else {
            logger.e("Error: Data is null");
            emit(NewfeedFailed(message: "Error: Data is null"));
          }
        } on DioException catch (e) {
          logger.e("$e");
          emit(NewfeedFailed(message: "$e"));
        }
      }
    });
  }
}
