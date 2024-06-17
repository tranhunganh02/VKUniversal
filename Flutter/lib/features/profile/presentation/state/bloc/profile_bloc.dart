import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';
import 'package:vkuniversal/features/profile/domain/usecase/load_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LoadProfileUseCase _loadProfileUseCase;
  ProfileBloc(this._loadProfileUseCase) : super(ProfileInitial()) {
    on<LoadProfile>(
      (event, emit) async {
        emit(ProfileLoading());
        try {
          final response = await _loadProfileUseCase(
              role: event.role, userIDToLoadProfile: event.userID);
          logger.d("At Profile Bloc: ${event.role} ${event.userID}");
          if (response is DataSuccess) {
            if (response.data != null) {
              logger.d("API Response: ${response.data as ProfileModel}");
              logger.d("Get thanh cong");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              ProfileModel profile = response.data as ProfileModel;
              logger.d(
                  "At Profile Bloc: ${profile.user.uid} ${profile.user.displayName}");
              prefs.setString('avatar', profile.user.avatar ?? avatarNotFound);
              prefs.setString(
                  'displayName', profile.user.displayName ?? avatarNotFound);
              emit(ProfileLoaded(
                  profile: profile, role: event.role, userID: event.userID));
            } else {
              emit(ProfileFailed(message: "Error: Data is null"));
            }
          } else {
            emit(ProfileFailed(message: "Error"));
          }
        } catch (e) {
          logger.e(e.toString());
          emit(ProfileFailed(message: e.toString()));
        }
      },
    );
  }

  // FutureOr<void> profileInitital(
  //     ProfileInitialEvent event, Emitter<ProfileState> emit) async {
  //   emit(ProfileLoading());
  // }
}
