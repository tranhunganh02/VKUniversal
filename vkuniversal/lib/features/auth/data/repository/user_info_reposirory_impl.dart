import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/data_sources/local/class_local_service.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/university.dart';
import 'package:vkuniversal/features/auth/domain/entities/major.dart';
import 'package:vkuniversal/features/auth/domain/repository/user_info_repository.dart';
import 'package:vkuniversal/features/auth/domain/usecases/refresh_token.dart';

class UserInfoReposiroryImpl implements UserInfoRepository {
  final ClassLocalService _classLocalService;
  final UserApiService _userApiService;

  UserInfoReposiroryImpl(this._userApiService,
      {required ClassLocalService classLocalService})
      : _classLocalService = classLocalService;
  @override
  Future<List<UniversityClassModel>> getClassList() async {
    return _classLocalService.getClassList();
  }

  @override
  Future<MajorEntity> getMajorList(int id) {
    return _classLocalService.getMajorByClassID(id);
  }

  @override
  Future<DataState<void>> updateStudentInfo({
    required int userID,
    required String accessToken,
    required Map<String, dynamic> info,
  }) async {
    try {
      final response =
          await _userApiService.updateStudentInfo(userID, accessToken, info);

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: response.response.statusCode,
              statusMessage: "Unauthorized",
            )));
      } else {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
