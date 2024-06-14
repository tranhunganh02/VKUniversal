part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignInEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignInEvent {
  final String password;
  const PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class LoginFormChanged extends SignInEvent {
  final String email;
  final String password;

  LoginFormChanged(this.email, this.password);
}

class SubbmitLoginForm extends SignInEvent {
  final String email;
  final String password;

  const SubbmitLoginForm({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
