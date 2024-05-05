import 'package:flutter/material.dart';

class MajorLabel extends StatelessWidget {
  const MajorLabel({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      "Software Engineer VKU",
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
    );
  }
}
