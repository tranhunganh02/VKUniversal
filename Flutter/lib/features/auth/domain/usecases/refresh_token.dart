import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/entities/user_response.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class RefreshToken
    implements UseCase<DataState<UserResponseEntity>, Authorization> {
  final AuthRepository _authRepository;

  RefreshToken({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<UserResponseEntity>> call({Authorization? data}) {
    return _authRepository.refreshToken(
      userID: data!.userID,
      refreshToken: data.refreshToken,
      accessToken: data.accessToken,
    );
  }
}
