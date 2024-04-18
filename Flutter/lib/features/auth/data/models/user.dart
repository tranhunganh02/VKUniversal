import 'package:vkuniversal/features/auth/domain/entities/User.dart';

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
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      createdAt: json['createdAt'] ?? '',
      lastLoginAt: json['lastLoginAt'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
