import 'package:flutter/material.dart';

class CircleCheckBox extends StatelessWidget {
  final bool value;
  final String label;
  CircleCheckBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
