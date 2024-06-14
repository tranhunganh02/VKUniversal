import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';

abstract class PostRepository {
  Future<DataState<PostEntity>> getPosts({
    required int userID,
    required String accessToken,
    required int page,
  });
}
