import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/domain/entities/User.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class SignUpWithEmail implements UseCase<DataState<UserEntity>, void> {
  final AuthRepository _authRepository;

  SignUpWithEmail({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<DataState<UserEntity>> call({void params}) {
    return _authRepository.signUpWithEmail(name: "", email: "", password: "");
  }
}
