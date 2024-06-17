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
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_comments.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_post_by_id.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc() : super(PostDetailInitial()) {
    on<LoadPostDetail>((event, emit) async {
      final _getPostByID = sl<GetPostById>();
      final _getComments = sl<GetComments>();

      if (state is PostDetailInitial) {
        emit(PostDetailLoading());
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
            final posts = response.data;
            final post = posts?.first as PostModel;
            final comments = commentResponse.data as List<CommentModel>;
            logger.d("At Post: ${post}");
            logger.d("At comment: ${comments.length}");

            emit(PostDetailLoaded(post: post, comments: comments));
          } else {
            logger.e(response.error.toString());
            emit(PostDetailFailed());
          }
        } on DioException catch (e) {
          logger.e("$e");
          emit(PostDetailFailed());
        }
      }
    });
  }
}
