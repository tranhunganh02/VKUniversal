import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_in_with_email.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithEmail _signInWithEmail;
  Logger _logger = Logger();

  SignInBloc(this._signInWithEmail) : super(SignInInitial()) {
    on<SubbmitLoginForm>((event, emit) async {
      try {
        final _request = SignInRequest(
          email: event.email,
          password: event.password,
        );

        final _response = await _signInWithEmail(params: _request);
        _logger.d(_response.data);

        if (_response is DataSuccess) {
          _logger.d('At Sign_in Block: Login Success ');
          emit(LoginSuccess(_response.data?.user as UserModel));
        }
        if (_response is DataFailed) {
          _logger
              .e('At Sign_in Block: Login Failure ${_response.error?.message}');

          emit(LoginFailure(_response.error?.message as String));
        }
      } catch (e) {
        _logger.e('At Sign_in Block: ${e}');
        emit(LoginFailure("An error occurred"));
      }
    });
  }
}
