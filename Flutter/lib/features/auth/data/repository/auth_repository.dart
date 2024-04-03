import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/domain/entities/User.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> logoutWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserEntity>> signInWithEmail(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserEntity>> signInWithGoogle() {
    throw UnimplementedError();
  }
}
