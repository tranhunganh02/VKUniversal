enum AcademicRank {
  PhoGiaoSu,
  GiaoSu,
}

extension FacultyExt on AcademicRank {
  String get name {
    switch (this) {
      case AcademicRank.PhoGiaoSu:
        return "Phó Giáo Sư";
      case AcademicRank.GiaoSu:
        return "Giáo Sư";
    }
  }
}
