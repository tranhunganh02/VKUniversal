import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';
import 'package:vkuniversal/features/auth/data/models/student_info_checker.dart';
import 'package:vkuniversal/features/auth/data/models/user_response.dart';
part 'auth_api_service.g.dart';

@RestApi(baseUrl: authAPIBaseURL)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/signup')
  Future<HttpResponse<UserResponse>> signUpWithEmail(
    @Body() SignUpRequest signUpRequest,
  );

  @POST('/login')
  Future<HttpResponse<UserResponse>> signInWithEmail(
    @Body() SignInRequest signInRequest,
  );

  @POST('/handlerRefreshToken')
  Future<HttpResponse<UserResponse>> refreshToken(
    @Header('x-client-id') int userID,
    @Header('x-rtoken-id') String refreshToken,
  );
  @POST('/logout')
  Future<HttpResponse<void>> logout(
    @Header('x-client-id') int userID,
    @Header('authorization') String? token,
  );

  @GET('/user/checkStudent')
  Future<HttpResponse<StudentInfoCheckerModel>> checkStudentInfoExist(
    @Header('x-client-id') int userID,
    @Header('authorization') String? token,
    @Body() CheckStudentInfoRequest request,
  );
}
