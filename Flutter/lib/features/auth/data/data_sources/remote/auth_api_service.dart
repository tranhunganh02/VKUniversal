import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';
part 'auth_api_service.g.dart';

@RestApi(baseUrl: authAPIBaseURL)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/signup')
  Future<HttpResponse> signUpWithEmail(
    @Body() SignUpRequest signUpRequest,
  );

  @POST('/login')
  Future<HttpResponse> signInWithEmail(
    @Body() SignInRequest signInRequest,
  );
}
