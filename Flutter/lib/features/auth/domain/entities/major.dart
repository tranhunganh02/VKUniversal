import 'package:equatable/equatable.dart';

class MajorEntity extends Equatable {
  final int major_id;
  final String major_name;
  final int faculty_id;

  MajorEntity({
    required this.major_id,
    required this.major_name,
    required this.faculty_id,
  });

  @override
  List<Object?> get props => [
        major_id,
        major_name,
        faculty_id,
      ];
}
