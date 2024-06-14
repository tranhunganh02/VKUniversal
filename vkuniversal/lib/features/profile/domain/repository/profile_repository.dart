import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/profile/domain/entities/profile.dart';

abstract interface class ProfileRepository {
  Future<DataState<ProfileEntity>> getProfile({
    required int role,
    required int userIDToLoadProfile,
  });

  Future<DataState<void>> updateProfile({
    int? userId,
    String? studentCode,
    String? surname,
    String? firstName,
    DateTime? dayOfBirth,
    int? gender,
    String? majorName,
    String? className,
  });
}
