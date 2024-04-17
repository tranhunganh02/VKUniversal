import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_up_with_email.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmail _signUpWithEmail;
  final SignInWithEmail _signInWithEmail;

  AuthBloc(this._signUpWithEmail, this._signInWithEmail)
      : super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final _request = SignUpRequest(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      final dataState = await _signUpWithEmail(params: _request);

      if (dataState is DataSuccess) {
        emit(AuthSignUpSuccess(dataState.data!.uid));
        print("Success");
      }
      if (dataState is DataFailed) {
        emit(AuthSignUpFailure(dataState.error!.message));
        print("Error");
      }
    });

    on<AuthLogin>((event, emit) async {
      final _request = SignInRequest(
        email: event.email,
        password: event.password,
      );

      final dataState = await _signInWithEmail(params: _request);

      if (dataState is DataSuccess) {
        emit(AuthLoginSuccess(dataState.data!.uid));
        print("Login Success");
      }
      if (dataState is DataFailed) {
        emit(AuthSignUpFailure(dataState.error!.message));
        print("Login Error");
      }
    });
  }
}
