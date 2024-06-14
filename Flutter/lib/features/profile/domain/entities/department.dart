import 'package:vkuniversal/features/auth/domain/entities/user.dart';

class DepartmentEnity extends UserEntity {
  final int? departmentID;
  final String? departmentName;

  DepartmentEnity({
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
}
