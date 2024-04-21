import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String content) {
  TextTheme textTheme = Theme.of(context).textTheme;
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: textTheme.labelSmall?.copyWith(color: colorScheme.onError),
        ),
        backgroundColor: colorScheme.error,
        duration: Duration(seconds: 2),
      ),
    );
}
