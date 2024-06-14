part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeEvent {}

class AuthInitial extends WelcomeEvent {}

class AuthSuccess extends WelcomeEvent {}

class AuthFailure extends WelcomeEvent {}
