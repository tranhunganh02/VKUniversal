import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';

class LikeAPost implements UseCase<DataState<void>, PostRequest> {
  final PostRepository _postRepository;

  LikeAPost({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<DataState<void>> call({PostRequest? data, Authorization? auth}) {
    return _postRepository.LikeThePost(
        userID: auth!.userID,
        accessToken: auth.accessToken,
        postID: data!.postID);
  }
}
