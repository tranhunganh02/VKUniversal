// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:vkuniversal/core/constants/constants.dart';
// import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';

// // part 'post_api_service.g.dart';

// @RestApi(baseUrl: authAPIBaseURL)
// abstract class PostApiService {
//   factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;

//   @POST('/post/all')
//   Future<HttpResponse<PostModel>> getPosts(
//     @Header('x-client-id') int userID,
//     @Header('x-rtoken-id') String accessToken,
//     @Body() int page,
//   );
// }
