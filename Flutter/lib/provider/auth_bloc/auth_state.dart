
abstract class AuthState {}

abstract class AuthActionState extends AuthState {}

class AuthInitial extends AuthState {

}
class AuthLoadedSuccessState extends AuthState {

}
class AuthLoadingState extends AuthState {

}
class AuthErrorState extends AuthState {

}
class AuthNavigateToSignUpActionPage extends AuthActionState {

}
class AuthNavigateToSignInActionPage extends AuthActionState {

}
class AuthLoginActionPage extends AuthActionState {

}
class AuthSignUpActionPage extends AuthActionState {

}
