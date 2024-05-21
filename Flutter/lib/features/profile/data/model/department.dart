import 'package:vkuniversal/features/auth/data/models/user.dart';

class DepartmentModel extends UserModel {
  final int? departmentID;
  final String? departmentName;

  DepartmentModel({
    super.uid,
    super.email,
    super.displayName,
    super.role,
    super.phoneNumber,
    super.createdAt,
    super.lastLoginAt,
    super.avatar,
    this.departmentID,
    this.departmentName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      uid: json['user_id'],
      email: json['email'],
      displayName: json['displayName'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'],
      lastLoginAt: json['lastLoginAt'],
      avatar: json['avatar'],
      departmentID: json['department_id'],
      departmentName: json['department_name'],
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
      'department_id': departmentID,
      'department_name': departmentName,
    };
  }
}
