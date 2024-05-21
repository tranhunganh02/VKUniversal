import 'package:vkuniversal/features/auth/domain/entities/User.dart';
import 'package:vkuniversal/features/profile/data/model/department.dart';
import 'package:vkuniversal/features/profile/data/model/lecture.dart';
import 'package:vkuniversal/features/profile/data/model/student.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    required super.role,
    required super.phoneNumber,
    required super.createdAt,
    required super.lastLoginAt,
    required super.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['user_id'] ?? 0,
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      createdAt: json['createdAt'] ?? '',
      lastLoginAt: json['lastLoginAt'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  static UserModel formJson(Map<String, dynamic> json, int role) {
    switch (role) {
      case 1:
        return StudentModel.fromJson(json);
      case 2:
        return LectureModel.fromJson(json);
      case 3:
        return DepartmentModel.fromJson(json);
      default:
        throw Exception('Invalid role');
    }
  }

  static Map<String, dynamic> toJson(int role) {
    switch (role) {
      case 1:
        return StudentModel().toJson();
      case 2:
        return LectureModel().toJson();
      case 3:
        return DepartmentModel().toJson();
      default:
        throw Exception('Invalid role');
    }
  }
}
