import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/profile/domain/entities/profile.dart';

class ProfileModel extends ProfileEntity {
  final String? userBio;
  final UserModel user;

  factory ProfileModel.fromJson(Map<String, dynamic> map, int role) {
    return ProfileModel(
      userBio: map['metadata']['user_bio'],
      user: UserModel.formJson(map['metadata']['user'], role),
    );
  }

  Map<String, dynamic> toJson(int role) {
    return {
      'metadata': {
        'user_bio': userBio,
        'user': UserModel.toJson(role),
      }
    };
  }

  ProfileModel({
    super.userID,
    super.studentCode,
    super.surName,
    super.firstName,
    super.dateOfBirth,
    super.gender,
    super.majorName,
    super.className,
    required this.userBio,
    required this.user,
  });
}
