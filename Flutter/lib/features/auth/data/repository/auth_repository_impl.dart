import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/email_password.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';
import 'package:vkuniversal/features/auth/data/models/student_info_checker.dart';
import 'package:vkuniversal/features/auth/data/models/user_response.dart';
import 'package:vkuniversal/features/auth/domain/entities/user_response.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_in_with_email.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  Logger _logger = Logger();

  AuthRepositoryImpl({required AuthApiService authApiService})
      : _authApiService = authApiService;

  @override
  Future<DataFailed<void>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> logoutWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserResponse>> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserResponse>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authApiService.signInWithEmail(SignInRequest(
        email: email,
        password: password,
      ));
      _logger.d("Signing in...");
      if (response.response.statusCode == HttpStatus.ok) {
        _logger.d("Sign in successful");
        _logger.d("Access token: " + response.data.token.accessToken);
        return DataSuccess(response.data);
      } else {
        RequestOptions options = RequestOptions();
        _logger.e("Sign in failed: ");
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserResponse>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _logger.d(email);
      final httpResponse = await _authApiService.signUpWithEmail(SignUpRequest(
        email: email,
        password: password,
        name: name,
      ));
      _logger.d("Signing up...");
      if (httpResponse.response.statusCode == HttpStatus.created) {
        _logger.d("Sign up successful");
        return DataSuccess(httpResponse.data);
      } else {
        _logger.e("Sign up failed: ");
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      _logger.e(e.message);
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserResponse>> signUpWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserResponseEntity>> refreshToken({
    required int userID,
    required String refreshToken,
    required String accessToken,
  }) async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();

      final response = await _authApiService.refreshToken(
        userID,
        refreshToken,
      );
      _logger.d("Refreshing token...");
      if (response.response.statusCode == HttpStatus.ok) {
        _pref.setString('refreshToken', response.data.token.refreshToken);
        _pref.setString('accessToken', response.data.token.accessToken);
        _logger.d("Refresh token successful");
        return DataSuccess(response.data);
      } else {
        _logger.e("Refresh token failed: ");
        final signIn = sl<SignInWithEmail>();
        LoginInfo loginInfo = SetUpLoginInfo(_pref);
        signIn(
            data: SignInRequest(
                email: loginInfo.email, password: loginInfo.password));
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<StudentInfoCheckerModel>> checkUserInfoExists(
      {required int userID, required String accessToken}) async {
    try {
      final response = await _authApiService.checkStudentInfoExist(
        userID,
        accessToken,
        CheckStudentInfoRequest(userId: userID),
      );

      _logger.d("Checking user info...");

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        _logger.e("Refresh token failed: ");
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
