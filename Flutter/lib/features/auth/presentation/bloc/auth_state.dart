part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final String? uid;

  AuthSignUpSuccess(this.uid);
}

final class AuthLoginSuccess extends AuthState {
  final String? uid;

  AuthLoginSuccess(this.uid);
}

final class AuthSignUpFailure extends AuthState {
  final String? message;

  AuthSignUpFailure(this.message);
}

final class AuthLoginFailure extends AuthState {
  final String? message;

  AuthLoginFailure(this.message);
}
