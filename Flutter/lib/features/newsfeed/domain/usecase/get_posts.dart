import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';

class GetPosts implements UseCase<DataState<List<PostEntity>>, PageRequest> {
  final PostRepository _postRepository;

  GetPosts({required PostRepository postRepository})
      : _postRepository = postRepository;

  @override
  Future<DataState<List<PostEntity>>> call(
      {PageRequest? data, Authorization? auth}) {
    return _postRepository.getPosts(
        userID: auth!.userID, accessToken: auth.accessToken, page: data!);
  }
}
