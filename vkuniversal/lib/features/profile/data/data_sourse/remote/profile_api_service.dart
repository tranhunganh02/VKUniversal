import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';

part 'profile_api_service.g.dart';

@RestApi(baseUrl: authAPIBaseURL)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio) = _ProfileApiService;
  @GET('/user/profile')
  Future<HttpResponse<ProfileModel>> getProfile(
    @Header('authorization') String? token,
    @Header('x-client-id') int? userId,
    @Query('user_id') int? userIdToLoadProfile,
    @Query('role') int? role,
  );
}
