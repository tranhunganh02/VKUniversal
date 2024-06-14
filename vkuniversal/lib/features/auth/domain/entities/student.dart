import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final int? studentID;
  final int? userID;
  final String? studentCode;
  final String? surname;
  final String? lastName;
  final DateTime? dateOfBirth;
  final int? gender;
  final int? classID;
  final int? status;

  StudentEntity({
    required this.studentID,
    required this.userID,
    required this.studentCode,
    required this.surname,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.classID,
    required this.status,
  });

  @override
  List<Object?> get props => [
        studentID,
        userID,
        studentCode,
        surname,
        lastName,
        dateOfBirth,
        gender,
        classID,
        status,
      ];
}
