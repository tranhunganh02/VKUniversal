import 'package:flutter/material.dart';
import 'package:vkuniversal/features/auth/presentation/pages/login.dart';
import 'package:vkuniversal/features/auth/presentation/pages/sign_up.dart';
import 'package:vkuniversal/features/auth/presentation/pages/welcome.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/home.dart';

import 'router_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => Home());
      case RoutesName.welcome:
        return MaterialPageRoute(
            builder: (BuildContext context) => WelcomePage());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpPage());
      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => Container());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("Not found"),
            ),
          );
        });
    }
  }
}
