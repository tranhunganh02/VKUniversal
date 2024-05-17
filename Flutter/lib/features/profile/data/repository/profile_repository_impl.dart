import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/usecases/refresh_token.dart';
import 'package:vkuniversal/features/profile/data/data_sourse/remote/profile_api_service.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';
import 'package:vkuniversal/features/profile/domain/entities/profile.dart';
import 'package:vkuniversal/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _profileApiService;
  Logger _logger = Logger();

  ProfileRepositoryImpl({required ProfileApiService profileApiService})
      : _profileApiService = profileApiService;
  @override
  Future<DataState<ProfileModel>> getProfile({
    required int role,
  }) async {
    try {
      final _prefs = await SharedPreferences.getInstance();

      String? accessToken = _prefs.getString("accessToken");
      String? refreshToken = _prefs.getString("refreshToken");
      String? userID = _prefs.getString("userID");
      int userIDInt = int.parse(userID!);

      Authorization _authorization = Authorization(
        userID: userIDInt,
        refreshToken: refreshToken!,
        accessToken: accessToken!,
      );

      // if (accessToken == null) {
      //   final _tokenParam = Authorization(
      //     userID: userIDInt,
      //     refreshToken: refreshToken!,
      //     accessToken: accessToken!,
      //   );
      //   final tokenResponse = await _refreshToken(params: _tokenParam);
      //   if (_tokenParam is DataSuccess) {
      //     await _prefs.setString(
      //         'email', tokenResponse.data!.user.email.toString());
      //     await _prefs.setString(
      //         'refreshToken', tokenResponse.data!.token.refreshToken);
      //     await _prefs.setString(
      //         'accessToken', tokenResponse.data!.token.accessToken);
      //   } else {}
      // }
      final response =
          await _profileApiService.getProfile(accessToken, userIDInt, role);
      if (response.response.statusCode == HttpStatus.ok) {
        _logger.d("Get Profile Data Successfully");
        return DataSuccess(response.data);
      } else if (response.response.statusCode ==
          HttpStatus.internalServerError) {}
      RequestOptions options = RequestOptions();
      return DataFailed(DioException(requestOptions: options));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> updateProfile(
      {int? userId,
      String? studentCode,
      String? surname,
      String? firstName,
      DateTime? dayOfBirth,
      int? gender,
      String? majorName,
      String? className}) {
    throw UnimplementedError();
  }
}
