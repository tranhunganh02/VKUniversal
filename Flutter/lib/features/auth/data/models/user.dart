import 'package:vkuniversal/features/auth/domain/entities/User.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    required super.imgUrl,
  });
}
