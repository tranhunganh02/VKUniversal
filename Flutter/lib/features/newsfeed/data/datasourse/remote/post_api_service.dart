import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';

part 'post_api_service.g.dart';

@RestApi(baseUrl: authAPIBaseURL)
abstract class PostApiService {
  factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;

  @GET('/post/all')
  Future<HttpResponse<List<PostModel>>> getPosts(
    @Header('x-client-id') int userID,
    @Header('authorization') String accessToken,
    @Body() PageRequest page,
  );

  @POST('/post/like')
  Future<HttpResponse<void>> LikeThePost(
    @Header('x-client-id') int userID,
    @Header('authorization') String accessToken,
    @Body() PostRequest postID,
  );
  @DELETE('/post/like')
  Future<HttpResponse<void>> UnLikeThePost(
    @Header('x-client-id') int userID,
    @Header('authorization') String accessToken,
    @Body() PostRequest postID,
  );
  @POST('/post')
  @MultiPart()
  Future<HttpResponse<void>> CreatePost(
    @Header('x-client-id') int? userID,
    @Header('authorization') String? accessToken,
    @Part(name: 'content') String? content,
    @Part(name: 'privacy') bool? privacy,
    @Part(name: 'post_type') int? postType,
    @Part(name: 'images') List<MultipartFile>? attachments,
  );

  @GET('/post/')
  Future<HttpResponse<List<PostModel>>> GetPostByID(
    @Header('x-client-id') int userID,
    @Header('authorization') String accessToken,
    @Query("post_id") int postID,
  );
}
