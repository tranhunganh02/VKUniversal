import 'package:equatable/equatable.dart';

class UserTokenEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  UserTokenEntity({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => throw UnimplementedError();
}
