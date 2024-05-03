part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeState {}

final class WelcomeInitial extends WelcomeState {}

final class LoggedIn extends WelcomeState {}

final class LoggedOut extends WelcomeState {}
