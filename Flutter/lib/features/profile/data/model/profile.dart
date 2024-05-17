import 'package:vkuniversal/features/profile/domain/entities/profile.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel(
      {required super.userID,
      required super.studentCode,
      required super.surName,
      required super.firstName,
      required super.dateOfBirth,
      required super.gender,
      required super.majorName,
      required super.className});

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      userID: map['user_id'],
      studentCode: map['student_code'],
      surName: map['surname'],
      firstName: map['last_name'],
      dateOfBirth: map['date_of_birth'],
      gender: map['gender'],
      majorName: map['major_name'],
      className: map['class_name'],
    );
  }
}
