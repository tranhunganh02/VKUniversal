import 'package:equatable/equatable.dart';

class StudentInfoCheckEntity extends Equatable {
  final bool isExist;

  StudentInfoCheckEntity({required this.isExist});

  @override
  List<Object?> get props => [isExist];
}
