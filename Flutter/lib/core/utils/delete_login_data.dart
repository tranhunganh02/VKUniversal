import 'package:shared_preferences/shared_preferences.dart';

DeleteLoginData() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  _pref.remove('accessToken');
  _pref.remove('refreshToken');
  _pref.remove('userID');
  _pref.remove('email');
  _pref.remove('password');
  _pref.remove('role');
}
