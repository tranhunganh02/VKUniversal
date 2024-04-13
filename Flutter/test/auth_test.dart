import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';

void main() {
  group("Sign up", () {
    test("Success With Email", () async {
      final dio = Dio();

      final authApiService = AuthApiService(dio);

      final expectedEmail = 'sdasdczxcz@vku.udn.vn';
      final expectedPassword = 'Tha@021103';
      final expectedName = 'Huyxoann';

      final response = await authApiService.signUpWithEmail(SignUpRequest(
          email: expectedEmail,
          password: expectedPassword,
          name: expectedName));

      expect(response.response.statusCode, HttpStatus.created);
    });
    test("Sign up fail", () async {
      final dio = Dio();

      final authApiService = AuthApiService(dio);

      final expectedEmail = '';
      final expectedPassword = '';
      final expectedName = 'Huyxoann';

      final response = await authApiService.signUpWithEmail(SignUpRequest(
          email: expectedEmail,
          password: expectedPassword,
          name: expectedName));

      expect(response.response.statusCode, HttpStatus.forbidden);
    });
  });
}
