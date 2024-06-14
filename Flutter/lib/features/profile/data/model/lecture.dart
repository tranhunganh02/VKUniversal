import 'package:vkuniversal/core/enum/academic_rank_enum.dart';
import 'package:vkuniversal/core/enum/degree_enum.dart';
import 'package:vkuniversal/core/enum/faculty_enum.dart';
import 'package:vkuniversal/core/enum/gender_enum.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';

class LectureModel extends UserModel {
  final int? lectureID;
  final String? surname;
  final String? lastname;
  final Gender? gender;
  final String? dateOfBirth;
  final Faculty? faculty;
  final Degree? degree;
  final AcademicRank? academicRank;

  LectureModel({
    super.uid,
    super.email,
    super.displayName,
    super.role,
    super.phoneNumber,
    super.createdAt,
    super.lastLoginAt,
    super.avatar,
    this.lectureID,
    this.surname,
    this.lastname,
    this.gender,
    this.dateOfBirth,
    this.faculty,
    this.degree,
    this.academicRank,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    print("Model in lecture: ${LectureModel(
      uid: json['user_id'],
      email: json['email'],
      avatar: json['avatar'],
      surname: json['surname'],
      lastname: json['last_name'],
      displayName: json['surname'] + " " + json['last_name'],
      gender: GenderEnumExt.fromJson(json),
      dateOfBirth: json['date_of_birth'],
      faculty: FacultyExt.fromJson(json),
      degree: DegreeExt.fromJson(json),
      academicRank: AcademicRankExt.fromJson(json),
    )}");
    return LectureModel(
      uid: json['user_id'],
      email: json['email'],
      phoneNumber: "json['phoneNumber']",
      createdAt: "json['createdAt']",
      lastLoginAt: "json['lastLoginAt']",
      avatar: json['avatar'],
      surname: json['surname'],
      lastname: json['last_name'],
      displayName: json['surname'] + " " + json['last_name'],
      gender: GenderEnumExt.fromJson(json),
      dateOfBirth: json['date_of_birth'],
      faculty: FacultyExt.fromJson(json),
      degree: DegreeExt.fromJson(json),
      academicRank: AcademicRankExt.fromJson(json),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': uid,
      'lectureID': lectureID,
      'gender': gender,
      'surname': surname,
      'last_name': lastname,
      'date_of_birth': dateOfBirth,
      'acedemic_rank': {
        'ar_id': academicRank,
        'ar_name': academicRank?.name,
      },
      'degree': {
        'degree_id': degree,
        'degree_name': degree?.name,
      },
      'faculty': {
        'faculty_id': faculty,
        'faculty_name': faculty?.name,
      },
      'avatar': avatar,
    };
  }
}
