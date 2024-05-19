import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/usecases/refresh_token.dart';
import 'package:vkuniversal/features/auth/domain/usecases/update_student_info.dart';

part 'add_user_info_event.dart';
part 'add_user_info_state.dart';

class AddUserInfoBloc extends Bloc<AddUserInfoEvent, AddUserInfoState> {
  final UpdateStudentInfo _updateStudentInfo;
  final RefreshToken _refreshToken;
  AddUserInfoBloc(this._updateStudentInfo, this._refreshToken)
      : super(AddUserInforInitial()) {
    Future<DataState<void>> UpdateStudentInfo(
      String? accessToken,
      int? userID,
      Map<String, dynamic> data,
    ) async {
      return await _updateStudentInfo(
        data: data,
        accessToken: accessToken,
        userID: userID,
      );
    }

    // String? accessToken;
    // String? userID;
    // int userIDInt;

    Logger _logger = Logger();
    // void SetUpAuthData(SharedPreferences _pref) {
    //   accessToken = _pref.getString('accessToken');
    //   userID = _pref.getString('userID');
    // }

    on<SubmitAddUserInfoForm>((event, emit) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      emit(AddUserInfoLoading());

      if (event.studentCode.isEmpty) {
        emit(AddUserInfoFailure("Student Code is required"));
        return;
      }
      if (event.classId == 0) {
        emit(AddUserInfoFailure("Class Name is required"));
        return;
      }
      try {
        Authorization authorization = SetUpAuthData(_pref);

        Map<String, dynamic> data = {};

        if (event.studentCode.isNotEmpty) {
          data['student_code'] = event.studentCode;
        }
        if (event.classId != 0) {
          data['class_id'] = event.classId;
        }
        if (event.surname != null) {
          data['surname'] = event.surname;
        }
        if (event.lastName != null) {
          data['last_name'] = event.lastName;
        }
        if (event.gender != null) {
          data['gender'] = event.gender;
        }

        DataState<void> _request = await UpdateStudentInfo(
            authorization.accessToken, authorization.userID, data);
        _logger.d(authorization.userID);

        if (_request is DataSuccess) {
          _pref.setBool("hasUserInfo", true);
          emit(AddUserInfoSuccess());
        } else {
          final DioException dioError = _request.error!;
          final int? statusCode = dioError.response?.statusCode;
          if (statusCode == HttpStatus.unauthorized) {
            _logger.e(_request.error!.response!.statusCode);

            final tokenResponse = await _refreshToken(data: authorization);

            if (tokenResponse is DataSuccess) {
              _logger.e("Change token thanh cong: " +
                  tokenResponse.data!.token.refreshToken);
              _pref.setString(
                  "accessToken", tokenResponse.data!.token.accessToken);
              _pref.setString(
                  "refreshToken", tokenResponse.data!.token.refreshToken);

              authorization = SetUpAuthData(_pref);
              _request = await UpdateStudentInfo(
                  authorization.accessToken, authorization.userID, data);

              if (_request is DataSuccess) {
                emit(AddUserInfoSuccess());
              } else {
                emit(AddUserInfoFailure("Something went wrong"));
              }
            } else {
              _logger
                  .e("Change token that bai: ${tokenResponse.error?.message}");
            }
          }
        }
      } catch (e) {
        _logger.e(' ${e}');
        emit(AddUserInfoFailure("An unexpected error occurred!!!"));
      }
    });
  }
}
