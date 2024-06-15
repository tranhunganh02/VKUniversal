import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/logout_common.dart';

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
          onPressed: () => LogoutCommon(context),
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
