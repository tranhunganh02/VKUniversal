import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/domain/entities/User.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class SignInWithGoogle implements UseCase<UserEntity, void> {
  final AuthRepository _authRepository;

  SignInWithGoogle(this._authRepository);

  @override
  Future<UserEntity> call({void params}) {
    throw UnimplementedError();
  }
}
