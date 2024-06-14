import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/profile/domain/entities/profile.dart';

class ProfileModel extends ProfileEntity {
  final String userBio;
  final UserModel user;

  factory ProfileModel.fromJson(Map<String, dynamic> map, int role) {
    print("Map: ${map}");
    final userBio = map['metadata']['user_bio'] as String?;
    if (userBio == null || userBio.isEmpty) {
      print("Warning: user_bio is null or empty");
      // Handle empty userBio (e.g., return default value, throw exception)
      // You can replace the following line with your desired handling logic
      return ProfileModel(
          userBio: '', user: UserModel.formJson(map['metadata']['user'], role));
    }

    print("Test : ${userBio}");

    final profileModel = ProfileModel(
      userBio: userBio,
      user: UserModel.formJson(map['metadata']['user'], role),
    );

    return profileModel;
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
