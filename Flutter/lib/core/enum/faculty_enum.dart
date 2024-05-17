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
}
