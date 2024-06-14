part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {}

final class SignUpInitial extends SignUpState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class SignUpLoading extends SignUpState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class SignUpSuccess extends SignUpState {
  final UserModel? user;

  SignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class SignUpFailure extends SignUpState {
  final String? message;

  SignUpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
