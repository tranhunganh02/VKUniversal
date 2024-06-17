import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/comment.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/comment_repository.dart';

class GetComments
    implements UseCase<DataState<List<CommentEntity>>, PostRequest> {
  final CommentRepository _commentRepository;

  GetComments({required CommentRepository commentRepository})
      : _commentRepository = commentRepository;

  @override
  Future<DataState<List<CommentEntity>>> call(
      {PostRequest? data, Authorization? auth}) {
    return _commentRepository.getComments(
        userID: auth!.userID,
        accessToken: auth.accessToken,
        postID: data!.postID);
  }
}
