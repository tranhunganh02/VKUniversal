import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/features/auth/data/models/student.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrlIos)
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @PUT('/user')
  Future<HttpResponse<void>> updateStudentInfo(
    @Header('x-client-id') int userID,
    @Header('authorization') String? token,
    @Body() Map<String, dynamic> body,
  );
}
