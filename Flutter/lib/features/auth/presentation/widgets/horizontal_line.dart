import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 2.0,
            color: colorScheme.onPrimary,
          ),
        ),
        Center(
          child: Text(
            '\t Or continue with \t',
            style: textTheme.bodySmall, // Adjust text style
          ),
        ),
        Expanded(
          child: Divider(
            height: 2.0, // Adjust thickness as needed
            color: colorScheme.onPrimary, // Adjust color as needed
          ),
        ),
      ],
    );
  }
}
