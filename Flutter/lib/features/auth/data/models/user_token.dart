import 'package:vkuniversal/features/auth/domain/entities/user_token.dart';

class UserTokenModel extends UserTokenEntity {
  UserTokenModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserTokenModel.fromJson(Map<String, dynamic> json) {
    return UserTokenModel(
      accessToken: json['asscessToken'] as String, // Handle potential typo
      refreshToken: json['refreshToken'] as String,
    );
  }
}
