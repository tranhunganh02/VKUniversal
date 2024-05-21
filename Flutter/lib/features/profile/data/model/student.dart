import 'package:vkuniversal/core/enum/gender_enum.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';

class StudentModel extends UserModel {
  final int? studentID;
  final String? studentCode;
  final String? surname;
  final String? lastname;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final int? addMissionYear;
  final int? status;
  final int? class_id;

  StudentModel({
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
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      uid: json['user_id'],
      email: json['email'],
      displayName: json['displayName'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'],
      lastLoginAt: json['lastLoginAt'],
      avatar: json['avatar'],
      studentID: json['studentID'],
      studentCode: json['student_code'],
      surname: json['surname'],
      lastname: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      gender: GenderEnumExt.fromJson(json),
      addMissionYear: json['addMissionYear'],
      status: json['status'],
      class_id: json['class_id'],
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
      'studentID': studentID,
      'student_code': studentCode,
      'surname': surname,
      'last_name': lastname,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'addMissionYear': addMissionYear,
      'status': status,
      'class_id': class_id,
    };
  }
}
