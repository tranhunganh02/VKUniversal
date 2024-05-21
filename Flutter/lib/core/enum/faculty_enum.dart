enum Faculty { KHMT, KTS_TMDT, KTMT_DT }

extension FacultyExt on Faculty {
  String get name {
    switch (this) {
      case Faculty.KHMT:
        return "Khoa học máy tính";
      case Faculty.KTS_TMDT:
        return "Kinh tế số & thương mại điện tử ";
      case Faculty.KTMT_DT:
        return "Kỹ thuật máy tính và điện tử";
    }
  }

  static Faculty fromJson(Map<String, dynamic> json) {
    switch (json['faculty']['faculty_id']) {
      case 1:
        return Faculty.KHMT;
      case 2:
        return Faculty.KTMT_DT;
      case 3:
        return Faculty.KTS_TMDT;
      default:
        return Faculty.KHMT;
    }
  }

  Map<String, dynamic> toJson() {
    switch (this) {
      case Faculty.KHMT:
        return {
          "faculty": {
            "faculty_id": Faculty.KHMT.index,
            "faculty_name": Faculty.KHMT.name,
          },
        };
      case Faculty.KTS_TMDT:
        return {
          "faculty": {
            "faculty_id": Faculty.KTS_TMDT.index,
            "faculty_name": Faculty.KTS_TMDT.name,
          },
        };
      case Faculty.KTMT_DT:
        return {
          "faculty": {
            "faculty_id": Faculty.KTMT_DT.index,
            "faculty_name": Faculty.KTMT_DT.name,
          },
        };
    }
  }
}
