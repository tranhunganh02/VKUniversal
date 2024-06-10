import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';

abstract class PostRepository {
  Future<DataState<List<PostEntity>>> getPosts({
    required int userID,
    required String accessToken,
    required PageRequest page,
  });
}
