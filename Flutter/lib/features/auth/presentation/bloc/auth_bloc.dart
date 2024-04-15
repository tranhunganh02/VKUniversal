import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vkuniversal/features/auth/data/models/sign_in_request.dart';
import 'package:vkuniversal/features/auth/data/models/sign_up_request.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_up_with_email.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmail _signUpWithEmail;
  AuthBloc({required SignUpWithEmail signUpWithEmail})
      : _signUpWithEmail = signUpWithEmail,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) {
      _signUpWithEmail();
    });
  }
}
