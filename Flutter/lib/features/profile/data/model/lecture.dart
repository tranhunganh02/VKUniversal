import 'package:vkuniversal/features/auth/data/models/user.dart';

class LectureModel extends UserModel {
  final int? lectureID;
  final String? lectererCode;
  final String? surname;
  final String? lastname;
  final int? gender;
  final String? dateOfBirth;
  final String? faculty;
  final String? degree;
  final String? academicRank;

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
    this.lectererCode,
    this.surname,
    this.lastname,
    this.gender,
    this.dateOfBirth,
    this.faculty,
    this.degree,
    this.academicRank,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      uid: json['user_id'],
      email: json['email'],
      displayName: json['displayName'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'],
      lastLoginAt: json['lastLoginAt'],
      avatar: json['avatar'],
      lectureID: json['lectureID'],
      lectererCode: json['lectererCode'],
      surname: json['surname'],
      lastname: json['last_name'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      faculty: json['faculty_name'],
      degree: json['degree_name'],
      academicRank: json['ar_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'lastLoginAt': lastLoginAt,
      'avatar': avatar,
      'lectureID': lectureID,
      'lectererCode': lectererCode,
      'surname': surname,
      'last_name': lastname,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'faculty_name': faculty,
      'degree_name': degree,
      'ar_name': academicRank,
    };
  }
}
