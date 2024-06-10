import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/domain/entities/student_info_checker.dart';
import 'package:vkuniversal/features/auth/domain/entities/user_response.dart';

abstract interface class AuthRepository {
  Future<DataState<UserResponseEntity>> signInWithGoogle();
  Future<DataState<UserResponseEntity>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<DataState<UserResponseEntity>> signUpWithGoogle();
  Future<DataState<UserResponseEntity>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<DataState<UserResponseEntity>> refreshToken({
    required int userID,
    required String refreshTokenPara,
    required String accessToken,
  });

  Future<DataState<StudentInfoCheckEntity>> checkUserInfoExists({
    required int userID,
    required String accessToken,
  });

  Future<void> logoutWithGoogle();
  Future<DataState<void>> logout();
}
