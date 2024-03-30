import 'package:vkuniversal/core/resourses/data_state.dart';
import 'package:vkuniversal/features/news_feed/data/models/post.dart';
import 'package:vkuniversal/features/news_feed/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  @override
  Future<DataState<List<PostModel>>> getPosts() {
    throw UnimplementedError();
  }
}
