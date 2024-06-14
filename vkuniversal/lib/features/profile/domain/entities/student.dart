import 'package:vkuniversal/core/enum/gender_enum.dart';
import 'package:vkuniversal/features/auth/domain/entities/User.dart';

class StudentEntity extends UserEntity {
  final int? studentID;
  final String? studentCode;
  final String? surname;
  final String? lastname;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final int? addMissionYear;
  final int? status;
  final int? class_id;

  StudentEntity({
    super.uid,
    super.email,
    super.displayName,
    super.role,
    super.phoneNumber,
    super.createdAt,
    super.lastLoginAt,
    super.avatar,
    this.studentID,
    this.studentCode,
    this.surname,
    this.lastname,
    this.dateOfBirth,
    this.gender,
    this.addMissionYear,
    this.status,
    this.class_id,
  });
}
