part of 'add_user_info_bloc.dart';

@immutable
sealed class AddUserInfoEvent {}

class SubmitAddUserInfoForm extends AddUserInfoEvent {
  final String studentCode;
  final String? surname;
  final String? lastName;
  final int classId;
  final int? gender;

  SubmitAddUserInfoForm({
    this.gender,
    required this.studentCode,
    this.surname,
    this.lastName,
    required this.classId,
  });
}
