import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int? userID;
  final String? studentCode;
  final String? surName;
  final String? firstName;
  final DateTime? dateOfBirth;
  final int? gender;
  final String? majorName;
  final String? className;

  ProfileEntity(
      {required this.userID,
      required this.studentCode,
      required this.surName,
      required this.firstName,
      required this.dateOfBirth,
      required this.gender,
      required this.majorName,
      required this.className});

  @override
  List<Object?> get props => [
        userID,
        studentCode,
        surName,
        firstName,
        dateOfBirth,
        gender,
        majorName,
        className
      ];
}
