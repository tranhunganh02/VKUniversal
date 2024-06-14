import 'package:equatable/equatable.dart';

class UserBioEntity extends Equatable {
  final int? userID;
  final String? bio;

  UserBioEntity({required this.userID, required this.bio});

  @override
  List<Object?> get props => throw UnimplementedError();
}
