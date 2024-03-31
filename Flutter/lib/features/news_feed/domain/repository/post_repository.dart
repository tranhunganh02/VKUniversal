import 'package:vkuniversal/core/resourses/data_state.dart';
import 'package:vkuniversal/features/news_feed/domain/entities/post.dart';

abstract interface class PostRepository {
  Future<DataState<List<PostEntity>>> getPosts();
}
