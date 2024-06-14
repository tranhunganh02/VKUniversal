import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? uid;
  final String? email;
  final String? displayName;
  final int? role;
  final String? phoneNumber;
  final String? createdAt;
  final String? lastLoginAt;
  final String? avatar;

  UserEntity({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    required this.phoneNumber,
    required this.createdAt,
    required this.lastLoginAt,
    required this.avatar,
  });

  @override
  List<Object?> get props {
    return [
      uid,
      email,
      displayName,
      role,
      phoneNumber,
      createdAt,
      lastLoginAt,
      avatar,
    ];
  }
}
