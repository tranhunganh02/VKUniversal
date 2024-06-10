import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/profile/domain/entities/profile.dart';
import 'package:vkuniversal/features/profile/domain/repository/profile_repository.dart';

class LoadProfileUseCase
    implements UseCase<DataState<ProfileEntity>, Authorization> {
  final ProfileRepository _profileRepository;

  LoadProfileUseCase({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  Future<DataState<ProfileEntity>> call(
      {Authorization? data, int? role, int? userIDToLoadProfile}) {
    return _profileRepository.getProfile(
        role: role!, userIDToLoadProfile: userIDToLoadProfile!);
  }
}
