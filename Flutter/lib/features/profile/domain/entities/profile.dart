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

  ProfileEntity({
    this.userID,
    this.studentCode,
    this.surName,
    this.firstName,
    this.dateOfBirth,
    this.gender,
    this.majorName,
    this.className,
  });

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
