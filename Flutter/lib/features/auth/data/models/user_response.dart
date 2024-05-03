import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/data/models/user_token.dart';
import 'package:vkuniversal/features/auth/domain/entities/user_response.dart';

class UserResponse extends UserResponseEntity {
  final UserModel user;
  final UserTokenModel token;

  UserResponse({required this.user, required this.token})
      : super(user: user, token: token);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        token: UserTokenModel.fromJson(json['tokens'] as Map<String, dynamic>));
  }
}
