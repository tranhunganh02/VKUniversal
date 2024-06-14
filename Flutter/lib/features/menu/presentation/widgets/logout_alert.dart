import 'package:flutter/material.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/config/routes/routes.dart';
import 'package:vkuniversal/core/utils/delete_login_data.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/domain/usecases/logout.dart';

class LogoutAlert extends StatelessWidget {
  const LogoutAlert({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text(
        "Logout confirmation",
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.primary,
        ),
      ),
      content: Text(
        "Are you sure you want to logout?",
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.primary,
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            sl<Logout>().call();
            Navigator.of(context).pop();
            DeleteLoginData();
            Navigator.pushAndRemoveUntil(
                context,
                Routes.generateRoute(RouteSettings(name: RoutesName.welcome)),
                (Route<dynamic> route) => false);
          },
          child: Text("Logout"),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
