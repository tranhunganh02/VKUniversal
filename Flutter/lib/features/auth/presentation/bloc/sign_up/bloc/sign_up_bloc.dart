import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_up_with_email.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpWithEmail _signUpWithEmail;

  SignUpBloc(this._signUpWithEmail) : super(SignUpInitial()) {
    on<SignUpFormSummitted>((event, emit) async {
      emit(SignUpLoading());
      final _request = SignUpRequest(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      final dataState = await _signUpWithEmail(params: _request);

      if (dataState is DataSuccess) {
        emit(SignUpSuccess(dataState.data!.user as UserModel));
        print("Success");
      }
      if (dataState is DataFailed) {
        emit(SignUpFailure(dataState.error?.message));
        print("Error");
      }
    });
  }
}
