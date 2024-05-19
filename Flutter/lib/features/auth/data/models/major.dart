import 'package:vkuniversal/features/auth/domain/entities/major.dart';

class MajorModel extends MajorEntity {
  MajorModel(
      {required super.major_id,
      required super.major_name,
      required super.faculty_id});

  factory MajorModel.fromJson(Map<String, dynamic> json) {
    return MajorModel(
      major_id: json['major_id'],
      major_name: json['major_name'],
      faculty_id: json['faculty_id'],
    );
  }
}
