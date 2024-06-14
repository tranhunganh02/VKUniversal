part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class ProfileLoaded extends ProfileState {
  final int role;
  final int userID;
  final ProfileModel profile;

  ProfileLoaded(
      {required this.role, required this.userID, required this.profile});

  @override
  List<Object?> get props => [profile];
}

final class ProfileFailed extends ProfileState {
  final String message;

  ProfileFailed({required this.message});
  @override
  List<Object?> get props => [message];
}
