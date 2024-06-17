part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class LoadProfile extends ProfileEvent {
  final int role;
  final int userID;

  LoadProfile({
    required this.role,
    required this.userID,
  });
}
