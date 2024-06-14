import 'package:vkuniversal/features/auth/domain/entities/student_info_checker.dart';

class StudentInfoCheckerModel extends StudentInfoCheckEntity {
  final bool isExist;

  StudentInfoCheckerModel({required this.isExist}) : super(isExist: false);

  factory StudentInfoCheckerModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoCheckerModel(
      isExist: json['metadata'],
    );
  }
}

class CheckStudentInfoRequest {
  final int userId;

  CheckStudentInfoRequest({required this.userId});

  factory CheckStudentInfoRequest.fromJson(Map<String, dynamic> json) {
    return CheckStudentInfoRequest(
      userId: json['user_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
    };
  }
}
