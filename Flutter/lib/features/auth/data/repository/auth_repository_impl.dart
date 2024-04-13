import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  late Logger _logger;

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
  Future<DataState<UserModel>> signInWithEmail(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserModel>> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserModel>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final httpResponse = await _authApiService.signUpWithEmail(
          SignUpRequest(email: email, password: password, name: name));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _logger.e("Sign up successful: ");
        return DataSuccess(httpResponse.data);
      } else {
        _logger.e("Sign up failed: ");
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> signUpWithGoogle() {
    throw UnimplementedError();
  }
}
