import 'package:vkuniversal/features/auth/domain/entities/student.dart';

class StudentModel extends StudentEntity {
  StudentModel({
    super.studentID,
    super.userID,
    super.studentCode,
    super.surname,
    super.lastName,
    super.dateOfBirth,
    super.gender,
    super.classID,
    super.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentID,
      'user_id': userID,
      'student_code': studentCode,
      'surname': surname,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'class_id': classID,
      'status': status,
    };
  }
}
