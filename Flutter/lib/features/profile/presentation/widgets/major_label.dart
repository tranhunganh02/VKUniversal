import 'package:flutter/material.dart';

class BioLabel extends StatelessWidget {
  final String bioContent;
  const BioLabel({super.key, required this.bioContent});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      bioContent,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
    );
  }
}
