import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/features/newsfeed/data/model/comment.dart';
import 'package:vkuniversal/features/newsfeed/data/model/comment_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';

part 'comment_api_service.g.dart';

@RestApi(baseUrl: authAPIBaseURL)
abstract class CommentApiService {
  factory CommentApiService(Dio dio, {String baseUrl}) = _CommentApiService;

  @GET('/post/comment')
  Future<HttpResponse<List<CommentModel>>> getComments(
    @Header('x-client-id') int userID,
    @Header('authorization') String accessToken,
    @Body() PostRequest postID,
  );

  @POST('/post/comment')
  Future<HttpResponse<void>> createComment(
    @Header('x-client-id') int userID,
    @Header('authorization') String accessToken,
    @Body() CommentRequest data,
  );
}
