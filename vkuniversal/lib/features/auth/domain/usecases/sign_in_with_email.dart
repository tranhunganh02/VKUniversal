import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/domain/entities/user_response.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class SignInWithEmail
    implements UseCase<DataState<UserResponseEntity>, SignInRequest> {
  final AuthRepository _authRepository;

  SignInWithEmail({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<DataState<UserResponseEntity>> call({SignInRequest? data}) {
    return _authRepository.signInWithEmail(
        email: data!.email, password: data.password);
  }
}
