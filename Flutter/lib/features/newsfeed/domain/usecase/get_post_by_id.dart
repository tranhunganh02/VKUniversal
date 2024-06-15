import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';

class GetPostById implements UseCase<DataState<List<PostEntity>>, PostRequest> {
  final PostRepository _postRepository;

  GetPostById({required PostRepository postRepository})
      : _postRepository = postRepository;

  @override
  Future<DataState<List<PostEntity>>> call(
      {PostRequest? data, Authorization? auth}) async {
    return await _postRepository.GetPostByID(
        userID: auth!.userID,
        accessToken: auth.accessToken,
        postID: data!.postID);
  }
}
