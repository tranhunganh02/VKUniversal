import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  const GoogleButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextButton.icon(
      onPressed: () {
        onPressed;
      },
      icon: Image.asset(
        'assets/images/logo/google_icon.jpg',
        width: 30,
      ),
      label: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.primaryContainer,
        ),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1.0),
      )),
    );
  }
}
