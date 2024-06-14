import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/domain/repository/user_info_repository.dart';

class UpdateStudentInfo
    implements UseCase<DataState<void>, Map<String, dynamic>> {
  final UserInfoRepository _infoReposirory;

  UpdateStudentInfo({required UserInfoRepository infoReposirory})
      : _infoReposirory = infoReposirory;
  @override
  Future<DataState<void>> call(
      {Map<String, dynamic>? data, String? accessToken, int? userID}) {
    return _infoReposirory.updateStudentInfo(
        userID: userID!, accessToken: accessToken!, info: data!);
  }
}
