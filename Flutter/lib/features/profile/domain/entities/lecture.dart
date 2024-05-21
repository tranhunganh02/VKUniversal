import 'package:vkuniversal/core/enum/academic_rank_enum.dart';
import 'package:vkuniversal/core/enum/degree_enum.dart';
import 'package:vkuniversal/core/enum/faculty_enum.dart';
import 'package:vkuniversal/core/enum/gender_enum.dart';
import 'package:vkuniversal/features/auth/domain/entities/user.dart';

class LectureEntity extends UserEntity {
  final int? lectureID;
  final String? lectererCode;
  final String? surname;
  final String? lastname;
  final Gender? gender;
  final String? dateOfBirth;
  final Faculty? facultyID;
  final Degree? degreeID;
  final AcademicRank? academicRank;

  LectureEntity({
    super.uid,
    super.email,
    super.displayName,
    super.role,
    super.phoneNumber,
    super.createdAt,
    super.lastLoginAt,
    super.avatar,
    this.lectureID,
    this.lectererCode,
    this.surname,
    this.lastname,
    this.gender,
    this.dateOfBirth,
    this.facultyID,
    this.degreeID,
    this.academicRank,
  });
}
