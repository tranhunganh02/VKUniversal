import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/domain/entities/major.dart';
import 'package:vkuniversal/features/auth/domain/entities/university_class.dart';

abstract interface class UserInfoRepository {
  Future<List<UniversityClassEntity>> getClassList();

  Future<MajorEntity> getMajorList(int id);

  Future<DataState<void>> updateStudentInfo({
    required int userID,
    required String accessToken,
    required Map<String, dynamic> info,
  });
}
