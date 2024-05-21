enum AcademicRank {
  None,
  PhoGiaoSu,
  GiaoSu,
}

extension AcademicRankExt on AcademicRank {
  String get name {
    switch (this) {
      case AcademicRank.PhoGiaoSu:
        return "Phó Giáo Sư";
      case AcademicRank.GiaoSu:
        return "Giáo Sư";
      case AcademicRank.None:
        return "Không có";
    }
  }

  static AcademicRank fromJson(Map<String, dynamic> json) {
    switch (json['acedemic_rank']['ar_id']) {
      case 1:
        return AcademicRank.GiaoSu;
      case 2:
        return AcademicRank.PhoGiaoSu;
      default:
        return AcademicRank.None;
    }
  }

  Map<String, dynamic> toJson() {
    switch (this) {
      case AcademicRank.None:
        return {
          'acedemic_rank': {
            'ar_id': AcademicRank.None.index,
            'ar_name': AcademicRank.None.name,
          }
        };
      case AcademicRank.GiaoSu:
        return {
          'acedemic_rank': {
            'ar_id': AcademicRank.GiaoSu.index,
            'ar_name': AcademicRank.GiaoSu.name,
          }
        };
      case AcademicRank.PhoGiaoSu:
        return {
          'acedemic_rank': {
            'ar_id': AcademicRank.PhoGiaoSu.index,
            'ar_name': AcademicRank.PhoGiaoSu.name,
          }
        };
    }
  }
}
