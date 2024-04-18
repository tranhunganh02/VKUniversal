part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class LoginSuccess extends SignInState {
  final UserModel user;

  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class LoginFailure extends SignInState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}
