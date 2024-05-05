import 'package:flutter/material.dart';

import '../../../../core/utils/icon_string.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    super.key,
    required this.updateAvate,
  });

  final void Function() updateAvate;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.topCenter,
      width: 30,
      height: 30,
      child: IconButton(
        onPressed: updateAvate,
        icon: IconList.editPencil,
        iconSize: 25,
        padding: EdgeInsets.all(2.5),
        tooltip: "Edit profile",
        style: ButtonStyle().copyWith(
            backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceDim)),
      ),
    );
  }
}
