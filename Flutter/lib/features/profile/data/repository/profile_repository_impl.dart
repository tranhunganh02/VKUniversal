import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/refresh_token.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/profile/data/data_sourse/remote/profile_api_service.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';
import 'package:vkuniversal/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _profileApiService;
  Logger _logger = Logger();

  ProfileRepositoryImpl({required ProfileApiService profileApiService})
      : _profileApiService = profileApiService;
  @override
  Future<DataState<ProfileModel>> getProfile({
    required int role,
    required int userIDToLoadProfile,
  }) async {
    try {
      final _prefs = await SharedPreferences.getInstance();

      Authorization authorization = SetUpAuthData(_prefs);

      final response = await _profileApiService.getProfile(
        authorization.accessToken,
        authorization.userID,
        userIDToLoadProfile,
        role,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        _logger.d("Get Profile Data Successfully");
        return DataSuccess(response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RefreshTokenCommon(_prefs);
      }
      RequestOptions options = RequestOptions();
      return DataFailed(DioException(requestOptions: options));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> updateProfile({
    int? userId,
    String? studentCode,
    String? surname,
    String? firstName,
    DateTime? dayOfBirth,
    int? gender,
    String? majorName,
    String? className,
  }) {
    throw UnimplementedError();
  }
}
