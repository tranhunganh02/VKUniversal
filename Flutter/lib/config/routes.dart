import 'package:flutter/material.dart';

import 'router_name.dart';

class Routes {
   static MaterialPageRoute generateRoute(RouteSettings settings){
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => Container());

      case RoutesName.login:
      return MaterialPageRoute(builder: (BuildContext context) => Container());

     case RoutesName.signUp:
      return MaterialPageRoute(builder: (BuildContext context) => const Scaffold(
        body: Center(
          child: Text("data"),
        ),
      ));

      case RoutesName.profile: 
        return MaterialPageRoute(builder: (BuildContext context) => Container());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text("Not found"),
            ),
          );
        });
    }
  }
}