import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<DataState<List<CommentEntity>>> getComments({
    required int userID,
    required String accessToken,
    required int postID,
  });

  Future<DataState<void>> createComment(
      {required int userID,
      required String accessToken,
      required int postID,
      required String content});
}
