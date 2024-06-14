import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';

class Unlike implements UseCase<DataState<void>, PostRequest> {
  final PostRepository postRepository;

  Unlike({required this.postRepository});

  @override
  Future<DataState<void>> call({PostRequest? data, Authorization? auth}) {
    return postRepository.UnlikeThePost(
      postID: data!.postID,
      accessToken: auth!.accessToken,
      userID: auth.userID,
    );
  }
}
