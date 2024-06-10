import 'package:flutter/material.dart';
import 'package:vkuniversal/features/auth/presentation/pages/add_user_info.dart';
import 'package:vkuniversal/features/auth/presentation/pages/login.dart';
import 'package:vkuniversal/features/auth/presentation/pages/sign_up.dart';
import 'package:vkuniversal/features/auth/presentation/pages/welcome.dart';
import 'package:vkuniversal/features/chat/presentation/pages/chat.dart';
import 'package:vkuniversal/features/chat/presentation/pages/list_chat.dart';
import 'package:vkuniversal/features/profile/presentation/pages/profile.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/home.dart';
import 'package:vkuniversal/main.dart';

import '../../features/chat/domain/entities/receiver.dart';
import '../../features/profile/presentation/pages/update_profile.dart';
import 'router_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
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
      case RoutesName.listChat:
        return MaterialPageRoute(
            builder: (BuildContext context) => ListChatScreen());
      case RoutesName.roomChat:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChatScreen(rc: arguments as Receiver,));
      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfileScreen());
      case RoutesName.addUserInfor:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddUserInfoPage());
      case RoutesName.updateProfile:
        return MaterialPageRoute(
            builder: (BuildContext context) => UpdateProfileScreen());
      case RoutesName.noInternet:
        return MaterialPageRoute(
            builder: (BuildContext context) => NoInternetPage());
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
