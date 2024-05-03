import 'package:equatable/equatable.dart';
import 'package:vkuniversal/features/auth/domain/entities/User.dart';
import 'package:vkuniversal/features/auth/domain/entities/user_token.dart';

class UserResponseEntity extends Equatable {
  final UserEntity user;
  final UserTokenEntity token;

  UserResponseEntity({required this.user, required this.token});

  @override
  List<Object?> get props {
    return [
      user,
      token,
    ];
  }
}
