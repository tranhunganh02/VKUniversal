import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/comment_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/comment_repository.dart';

class CreateCommentUsecase implements UseCase<DataState<void>, CommentRequest> {
  final CommentRepository _commentRepository;

  CreateCommentUsecase({required CommentRepository commentRepository})
      : _commentRepository = commentRepository;

  @override
  Future<DataState<void>> call({CommentRequest? data, Authorization? auth}) {
    return _commentRepository.createComment(
        userID: auth!.userID,
        accessToken: auth.accessToken,
        postID: data!.postID,
        content: data.content);
  }
}
