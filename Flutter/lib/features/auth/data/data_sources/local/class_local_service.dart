import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vkuniversal/features/auth/data/models/major.dart';
import 'package:vkuniversal/features/auth/data/models/university.dart';

class ClassLocalService {
  Future<List<UniversityClassModel>> getClassList() async {
    final String response =
        await rootBundle.loadString('assets/data/university_class.json');

    final List<dynamic> data = await json.decode(response);

    return data
        .map((json) =>
            UniversityClassModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<MajorModel> getMajorByClassID(int id) async {
    final String response =
        await rootBundle.loadString('assets/data/major.json');

    final List<dynamic> majors = await json.decode(response);

    List<MajorModel> data = majors
        .map((json) => MajorModel.fromJson(json as Map<String, dynamic>))
        .toList();

    for (MajorModel major in data) {
      if (major.major_id == id) {
        return major;
      }
    }
    return data.first;
  }
}
