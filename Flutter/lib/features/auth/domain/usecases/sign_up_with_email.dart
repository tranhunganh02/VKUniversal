import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/domain/entities/user_response.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class SignUpWithEmail
    implements UseCase<DataState<UserResponseEntity>, SignUpRequest> {
  final AuthRepository _authRepository;

  SignUpWithEmail(this._authRepository);

  @override
  Future<DataState<UserResponseEntity>> call({SignUpRequest? params}) async {
    print("Email: ${params?.email}");
    return await _authRepository.signUpWithEmail(
      name: params!.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpRequest {
  final String email;
  final String password;
  final String name;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
  });
}
