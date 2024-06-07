import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class Logout implements UseCase<DataState<void>, Authorization> {
  final AuthRepository _authRepository;

  Logout({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<void>> call({Authorization? data}) {
    return _authRepository.logout();
  }
}
