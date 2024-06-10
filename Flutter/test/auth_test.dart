import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';

void main() {
  group("Auth Testing...", () {
    test("Login with right email", () async {
      final dio = Dio();
      Logger _logger = Logger();
      final authApiService = AuthApiService(dio);

      final expectedEmail = 'htsang.tg@vku.udn.vn';
      final expectedPassword = '123456789';

      final response = await authApiService.signInWithEmail(SignInRequest(
        email: expectedEmail,
        password: expectedPassword,
      ));

_logger.d(response.data);
      _logger.d(response.response.statusMessage);

      expect(response.response.statusCode, HttpStatus.ok);
    });
    test("Sign up with right input", () async {
      final dio = Dio();
      Logger _logger = Logger();
      final authApiService = AuthApiService(dio);

      final expectedName = 'Huy';
      final expectedEmail = 'huytest123122@vku.udn.vn';
      final expectedPassword = 'Tha@021103';

      final response = await authApiService.signUpWithEmail(SignUpRequest(
        name: expectedName,
        email: expectedEmail,
        password: expectedPassword,
      ));

      _logger.d(response.response.statusMessage);

      expect(response.response.statusCode, HttpStatus.created);
    });
    
  });
}
