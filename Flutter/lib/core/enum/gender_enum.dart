enum Gender { male, female }

extension GenderEnumExt on Gender {
  String get name {
    switch (this) {
      case Gender.male:
        return "Nam";
      case Gender.female:
        return "Nữ";
    }
  }

  static Gender fromJson(Map<String, dynamic> json) {
    switch (json['gender']) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  Map<String, dynamic> toJson() {
    switch (this) {
      case Gender.male:
        return {'gender': Gender.male.index};
      case Gender.female:
        return {'gender': Gender.female.index};
    }
  }
}
