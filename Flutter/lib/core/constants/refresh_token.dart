import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/domain/usecases/refresh_token.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';

Future<void> RefreshTokenCommon() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  final refreshTokenUseCase = sl<RefreshToken>();

  final authorization = SetUpAuthData(_pref);

  final tokenResponse = await refreshTokenUseCase(data: authorization);

  if (tokenResponse is DataSuccess) {
    _pref.setString("accessToken", tokenResponse.data!.token.accessToken);
    _pref.setString("refreshToken", tokenResponse.data!.token.refreshToken);
  } else {
    LoggedOut();
  }
}
