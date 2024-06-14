import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';
import 'package:vkuniversal/features/profile/domain/usecase/load_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LoadProfileUseCase _loadProfileUseCase;
  ProfileBloc(this._loadProfileUseCase) : super(ProfileInitial()) {
    emit(ProfileLoading());
    on<ProfileInitialEvent>(profileInitital);
    on<LoadProfile>(
      (event, emit) async {
        Logger _logger = Logger();
        try {
          final response = await _loadProfileUseCase(
              role: event.role, userIDToLoadProfile: event.userID);

          if (response is DataSuccess) {
            _logger.d("API Response: ${response.data}");
            if (response.data != null) {
              _logger.d("API Response: ${response.data}");
              _logger.d("Get thanh cong");
              emit(
                ProfileLoaded(
                  profile: response.data as ProfileModel,
                  role: event.role,
                  userID: event.userID,
                ),
              );
            } else {
              emit(ProfileFailed(message: "Error: Data is null"));
            }
          } else {
            emit(ProfileFailed(message: "Error"));
          }
        } on DioException catch (e) {
          emit(ProfileFailed(message: e.toString()));
        }
      },
    );
  }

  FutureOr<void> profileInitital(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
  }
}
