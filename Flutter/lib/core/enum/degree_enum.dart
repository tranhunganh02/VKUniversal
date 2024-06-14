enum Degree { TienSi, ThacSi, CuNhan }

extension DegreeExt on Degree {
  String get name {
    switch (this) {
      case Degree.CuNhan:
        return "Cử Nhân";
      case Degree.TienSi:
        return "Tiến Sĩ";
      case Degree.ThacSi:
        return "Thạc Sĩ";
    }
  }

  static Degree fromJson(Map<String, dynamic> json) {
    switch (json['degree']['degree_id']) {
      case 1:
        return Degree.TienSi;
      case 2:
        return Degree.ThacSi;
      default:
        return Degree.CuNhan;
    }
  }

  Map<String, dynamic> toJson() {
    switch (this) {
      case Degree.CuNhan:
        return {
          'degree': {
            'degree_id': Degree.CuNhan.index,
            'degree_name': Degree.CuNhan.name,
          },
        };
      case Degree.TienSi:
        return {
          'degree': {
            'degree_id': Degree.TienSi.index,
            'degree_name': Degree.TienSi.name,
          },
        };
      case Degree.ThacSi:
        return {
          'degree': {
            'degree_id': Degree.ThacSi.index,
            'degree_name': Degree.ThacSi.name,
          },
        };
    }
  }
}
