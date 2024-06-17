import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/comment_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/create_comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    final _createComment = sl<CreateCommentUsecase>();
    on<CreateComment>((event, emit) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      Authorization authorization = SetUpAuthData(_pref);
      final commentRequest =
          CommentRequest(postID: event.postID, content: event.content);
      final response =
          await _createComment(data: commentRequest, auth: authorization);

      if (response is DataSuccess) {
        emit(CreateCommentSuccess());
      } else {
        emit(CreateCommentFailed());
      }
    });
  }
}
