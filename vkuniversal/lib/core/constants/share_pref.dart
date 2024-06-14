import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/data/models/email_password.dart';

Authorization SetUpAuthData(SharedPreferences _pref) {
  String accessToken = _pref.getString('accessToken') ?? '';
  String refreshToken = _pref.getString('refreshToken') ?? '';
  int userID = _pref.getInt('userID') ?? 0;

  return Authorization(
      userID: userID, refreshToken: refreshToken, accessToken: accessToken);
}

LoginInfo SetUpLoginInfo(SharedPreferences _pref) {
  String email = _pref.getString('email') ?? '';
  String password = _pref.getString('password') ?? '';
  return LoginInfo(email: email, password: password);
}

Future<int> GetUserRoleDefault() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  return _pref.getInt('role') ?? 0;
}
