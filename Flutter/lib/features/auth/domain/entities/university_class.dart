import 'package:equatable/equatable.dart';

class UniversityClassEntity extends Equatable {
  final int class_id;
  final String class_name;
  final int? major_id;

  UniversityClassEntity({
    required this.class_id,
    required this.class_name,
    this.major_id,
  });

  @override
  List<Object?> get props => [
        class_id,
        class_name,
        major_id,
      ];
}
