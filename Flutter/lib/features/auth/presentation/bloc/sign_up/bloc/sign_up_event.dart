part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {}

final class SignUpFormSummitted extends SignUpEvent {
  final String email;
  final String password;
  final String name;

  SignUpFormSummitted({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

final class AuthLoginSuccessEvent extends SignUpEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
