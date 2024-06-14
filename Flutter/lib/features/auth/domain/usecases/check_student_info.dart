import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/entities/student_info_checker.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class CheckUserInfoExists
    implements UseCase<DataState<StudentInfoCheckEntity>, Authorization> {
  final AuthRepository _authRepository;

  CheckUserInfoExists({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<StudentInfoCheckEntity>> call({Authorization? data}) {
    return _authRepository.checkUserInfoExists(
        userID: data!.userID, accessToken: data.accessToken);
  }
}
