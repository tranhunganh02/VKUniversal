import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/error/LoginError.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_in_with_email.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithEmail _signInWithEmail;
  Logger _logger = Logger();

  SignInBloc(this._signInWithEmail) : super(LoginInitial()) {
    on<EmailChanged>((event, emit) async {});
    on<SubbmitLoginForm>((event, emit) async {
      emit(LoginLoading());
      if (event.email.isEmpty && event.password.isEmpty) {
        emit(LoginFailure("Email is required and password is required!"));
        return;
      }
      if (event.email.isEmpty) {
        emit(LoginFailure("Email is required!"));
        return;
      }
      if (!event.email.contains('@vku.udn.vn')) {
        emit(LoginFailure("Email must be end with @vku.udn.vn"));
        return;
      }
      if (event.password.isEmpty) {
        emit(LoginFailure("Password is required!"));
        return;
      }
      try {
        final _request = SignInRequest(
          email: event.email,
          password: event.password,
        );

        final _response = await _signInWithEmail(data: _request);
        _logger.d(_response.data);

        if (_response is DataSuccess) {
          _logger.d('At Sign_in Block: Login Success ');
          _logger.d('User Email: ${_response.data!.user.email.toString()}');

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', _response.data!.user.email.toString());
          await prefs.setString('password', event.password);

          await prefs.setInt('userID', _response.data!.user.uid!);
          await prefs.setInt('role', _response.data!.user.role!);
          await prefs.setString(
              'refreshToken', _response.data!.token.refreshToken);
          await prefs.setString(
              'accessToken', _response.data!.token.accessToken);
          _logger.d('Access: ' + _response.data!.token.accessToken);

          emit(LoginSuccess(_response.data?.user as UserModel));
        }
        if (_response is DataFailed) {
          _logger.e(_response.error!.type);
          if (_response.error?.type == DioExceptionType.badResponse) {
            emit(LoginFailure(LoginError().userNotFound));
          } else {
            emit(LoginFailure("An unexpected error occurred"));
          }
        }
      } catch (e) {
        _logger.e('At Sign_in Block: ${e}');
        emit(LoginFailure("An unexpected error occurred!!!"));
      }
    });
  }
}
