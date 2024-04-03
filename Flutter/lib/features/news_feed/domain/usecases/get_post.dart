import 'package:vkuniversal/core/resourses/data_state.dart';
import 'package:vkuniversal/core/usecases/usecase.dart';
import 'package:vkuniversal/features/news_feed/domain/entities/post.dart';
import 'package:vkuniversal/features/news_feed/domain/repository/post_repository.dart';

class GetPostUseCase implements UseCase<DataState<List<PostEntity>>, void> {
  final PostRepository _postRepository;

  GetPostUseCase(this._postRepository);

  @override
  Future<DataState<List<PostEntity>>> call({void params}) {
    return _postRepository.getPosts();
  }
}
