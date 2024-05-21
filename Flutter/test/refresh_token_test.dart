import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/data_sources/local/class_local_service.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/student_info_checker.dart';
import 'package:vkuniversal/features/profile/data/data_sourse/remote/profile_api_service.dart';

void main() {
  test(
    "Get token data",
    () async {
      initializeDependencies();

      Logger _logger = Logger();

      final authApiService = sl<AuthApiService>();

      final userID = 13;
      final refreshToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzLCJlbWFpbCI6Imh1eXRuLjIxaXRAdmt1LnVkbi52biIsImlhdCI6MTcxNTc5MDM1OCwiZXhwIjoxNzE1ODc2NzU4fQ.rXfjZPLwDLYm6-GVB4NudV6qkYyd1rn-mNEdqE9aOF0';
      final response = await authApiService.refreshToken(
        userID,
        refreshToken,
      );

      _logger.d(response.response.statusMessage);

      expect(response.response.statusCode, HttpStatus.ok);
    },
  );
  test(
    "Test get profile user",
    () async {
      initializeDependencies();

      Logger _logger = Logger();

      final profileService = sl<ProfileApiService>();

      final userID = 13;
      final accessToke =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzLCJlbWFpbCI6Imh1eXRuLjIxaXRAdmt1LnVkbi52biIsInJvbGUiOjAsImlhdCI6MTcxNTc5MjM2NywiZXhwIjoxNzE1Nzk0MTY3fQ.JqndJQhpEbWCPfquvsmHk8rXldZqI5vesucMDx9V75Q';
      final role = 1;

      final response =
          await profileService.getProfile(accessToke, userID, role, 1);

      _logger.d(response.data.toString());

      expect(response.response.statusCode, HttpStatus.ok);
    },
  );

  test("Check student info exists", () async {
    initializeDependencies();
    Logger _logger = Logger();

    final authApiService = sl<AuthApiService>();

    final userID = 9;
    final accessToke =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjksImVtYWlsIjoiaHV5dG4uMjFpdEB2a3UudWRuLnZuIiwicm9sZSI6MSwiaWF0IjoxNzE1OTMwNzYzLCJleHAiOjE3MTU5MzI1NjN9.6c8E8TpFM8v5X1LnSXzJf8eNnk6FDL0o-2SY76i2RZs';

    final response = await authApiService.checkStudentInfoExist(
      userID,
      accessToke,
      CheckStudentInfoRequest(userId: userID),
    );

    _logger.d(response.data.toString());

    expect(response.response.data['metadata'], true);
  });
  test("Load class list", () {
    TestWidgetsFlutterBinding.ensureInitialized();
    initializeDependencies();

    Logger _logger = Logger();

    final _classService = ClassLocalService();

    final list = _classService.getClassList();

    _logger.d(list);
  });
  test("Test Update", () async {
    initializeDependencies();

    Logger _logger = Logger();
    final _userInfoService = sl<UserApiService>();

    final userID = 9;
    final accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjksImVtYWlsIjoiaHV5dG4uMjFpdEB2a3UudWRuLnZuIiwicm9sZSI6MSwiaWF0IjoxNzE2MTA5NDYxLCJleHAiOjE3MTYxMTEyNjF9.4CLxSFhxuEkUtC1iuUdcsykJtRyx9QBeyEf_IcbCfdA';

    final Map<String, dynamic> userInfo2 = {
      "user_id": "9",
      "student_code": "21IT666",
      "gender": 1,
      "class_id": 32
    };

    final response = await _userInfoService.updateStudentInfo(
        userID, accessToken, userInfo2);
    _logger.d(response.response.data.toString());

    expect(response.response.statusCode, HttpStatus.ok);
  });
  test("Test Get Student Profile", () async {
    initializeDependencies();

    Logger _logger = Logger();

    final userID = 12;
    final accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJlbWFpbCI6InRuaEB2a3UudWRuLnZuIiwicm9sZSI6MSwiaWF0IjoxNzE2MTk4MjU2LCJleHAiOjE3MTYyMTQ0NTZ9.P18HrD2c1Ob5zWOM9POmjWt_8FHrJY0HSWqT2J6i6_Q';
    final role = 1;

    final _profileService = sl<ProfileApiService>();
    final response =
        await _profileService.getProfile(accessToken, userID, userID, role);

    _logger.d(response.response.data.toString());

    expect(response.response.statusCode, HttpStatus.ok);
  });
  test("Get Lecture Profile", () async {
    initializeDependencies();

    Logger _logger = Logger();

    final userID = 13;
    final accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzLCJlbWFpbCI6Imx2bWluaEB2a3UudWRuLnZuIiwicm9sZSI6MiwiaWF0IjoxNzE2MjAwNDk5LCJleHAiOjE3MTYyMTY2OTl9.njxH4LC6v6KPxm3GWqUTQDzaG8ljVAmsknxMaMrjR9E';
    final role = 2;

    final _profileService = sl<ProfileApiService>();
    final response =
        await _profileService.getProfile(accessToken, userID, userID, role);

    _logger.d(response.response.data.toString());

    expect(response.response.statusCode, HttpStatus.ok);
  });
  test("Get Department Profile", () async {
    initializeDependencies();

    Logger _logger = Logger();

    final userID = 16;
    final accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE2LCJlbWFpbCI6ImNzQHZrdS51ZG4udm4iLCJyb2xlIjozLCJpYXQiOjE3MTYyMDA1NzYsImV4cCI6MTcxNjIxNjc3Nn0.X0XvPENKnj3GCJq4_AhvtcKNBJK8mUXmiIt1wTT5Re4';
    final role = 3;

    final _profileService = sl<ProfileApiService>();
    final response =
        await _profileService.getProfile(accessToken, userID, userID, role);

    _logger.d(response.response.data.toString());

    expect(response.response.statusCode, HttpStatus.ok);
  });
}
