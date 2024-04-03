import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/domain/entities/User.dart';

abstract interface class AuthRepository {
  Future<DataState<UserEntity>> signInWithGoogle();
  Future<DataState<UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> logoutWithGoogle();
  Future<void> logout();
}
