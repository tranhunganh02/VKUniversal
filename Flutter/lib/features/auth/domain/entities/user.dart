import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String imgUrl;

  UserEntity({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.imgUrl,
  });

  @override
  List<Object?> get props {
    return [
      uid,
      email,
      displayName,
      imgUrl,
    ];
  }
}
