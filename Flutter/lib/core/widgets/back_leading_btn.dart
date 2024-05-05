import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';

class BackLeadingBtn extends StatelessWidget {
  const BackLeadingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.surface.withOpacity(0.75),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: IconList.backArrow,
        tooltip: "Back to previous",
      ),
    );
  }
}
