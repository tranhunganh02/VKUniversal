class Authorization {
  int userID;
  String refreshToken;
  String accessToken;

  Authorization({
    required this.userID,
    required this.refreshToken,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'refreshToken': refreshToken,
      'accessToken': accessToken,
    };
  }
}
