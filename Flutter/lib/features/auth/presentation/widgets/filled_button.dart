import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';

class FilledButtonCustom extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  final double heightButton;
  final double widthPercent;
  const FilledButtonCustom({
    super.key,
    required this.label,
    required this.onPress, 
    required this.heightButton, required this.widthPercent,
  });

  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: width * widthPercent,
      height: heightButton,
      child: FilledButton(
        onPressed: onPress,
        child: Text(
          label,
          style: textTheme.labelLarge
              ?.copyWith(color: colorScheme.onPrimaryContainer),
        ),
        style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer),
      ),
    );
  }
}
