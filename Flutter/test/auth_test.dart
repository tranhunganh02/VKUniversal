import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';

void main() {
  group("Sign up", () {
    test("login test", () async {
      final dio = Dio();
      Logger _logger = Logger();
      final authApiService = AuthApiService(dio);

      final expectedEmail = 'huytn.21it@vku.udn.vn';
      final expectedPassword = 'Tha@021103';

      final response = await authApiService.signInWithEmail(SignInRequest(
        email: expectedEmail,
        password: expectedPassword,
      ));

      _logger.d(response.response.statusMessage);

      expect(response.response.statusCode, HttpStatus.ok);
    });
    test("Sign in fail", () async {
      final dio = Dio();

      final authApiService = AuthApiService(dio);

      final expectedEmail = 'huytn.21it@vku.udn.vn';
      final expectedPassword = 'assdsasdsass';

      final response = await authApiService.signInWithEmail(
        SignInRequest(
          email: expectedEmail,
          password: expectedPassword,
        ),
      );

      expect(response.response.statusCode, HttpStatus.ok);
    });
  });
}
