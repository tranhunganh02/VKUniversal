import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  @override
  Future<DataState<PostEntity>> getPosts({
    required int userID,
    required String accessToken,
    required int page,
  }) {
    throw UnimplementedError();
  }
}
