import 'package:flutter/material.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/config/routes/routes.dart';
import 'package:vkuniversal/core/utils/delete_login_data.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/domain/usecases/logout.dart';

void LogoutCommon(BuildContext context) {
  sl<Logout>().call();
  Navigator.of(context).pop();
  DeleteLoginData();
  Navigator.pushAndRemoveUntil(
      context,
      Routes.generateRoute(RouteSettings(name: RoutesName.welcome)),
      (Route<dynamic> route) => false);
}
