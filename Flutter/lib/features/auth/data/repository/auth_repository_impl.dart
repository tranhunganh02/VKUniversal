import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  Logger _logger = Logger();

  AuthRepositoryImpl({required AuthApiService authApiService})
      : _authApiService = authApiService;

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> logoutWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserModel>> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authApiService.signInWithEmail(SignInRequest(
        email: email,
        password: password,
      ));
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> signUpWithEmail({
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
        _logger.d("Sign up successful: ");
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
  Future<DataState<UserModel>> signUpWithGoogle() {
    throw UnimplementedError();
  }
}
