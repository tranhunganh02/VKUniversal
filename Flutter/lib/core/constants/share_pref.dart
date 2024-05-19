import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';

Authorization SetUpAuthData(SharedPreferences _pref) {
  String accessToken = _pref.getString('accessToken') ?? '';
  String refreshToken = _pref.getString('refreshToken') ?? '';
  String userID = _pref.getString('userID') ?? "0";

  int userIDInt = int.parse(userID);

  return Authorization(
      userID: userIDInt, refreshToken: refreshToken, accessToken: accessToken);
}
