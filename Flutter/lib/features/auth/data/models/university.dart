import 'package:vkuniversal/features/auth/domain/entities/university_class.dart';

class UniversityClassModel extends UniversityClassEntity {
  UniversityClassModel({
    required super.class_id,
    required super.class_name,
    super.major_id,
  });
  factory UniversityClassModel.fromJson(Map<String, dynamic> json) {
    return UniversityClassModel(
      class_id: json['class_id'],
      class_name: json['class_name'],
      major_id: json['major_id'],
    );
  }
}
