part of 'add_user_info_bloc.dart';

@immutable
abstract class AddUserInfoState extends Equatable {
  const AddUserInfoState();

  @override
  List<Object> get props => [];
}

final class AddUserInforInitial extends AddUserInfoState {}

final class AddUserInfoLoading extends AddUserInfoState {}

final class AddUserInfoSuccess extends AddUserInfoState {
}

final class AddUserInfoFailure extends AddUserInfoState {
  final String message;

  const AddUserInfoFailure(this.message);

  @override
  List<Object> get props => [message];
}
