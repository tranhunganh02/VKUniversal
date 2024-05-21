enum Degree { CuNhan, TienSi, ThacSi }

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
}
