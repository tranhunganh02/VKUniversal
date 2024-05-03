import 'package:flutter/material.dart';

import '../../../../core/utils/icon_string.dart';

class update_button extends StatelessWidget {
  const update_button({
    super.key, required this.updateAvate,
  });

  final void Function() updateAvate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(50)),
          color: Colors.grey[400]),
      child: Center(
        child: IconButton(
            onPressed: updateAvate,
            icon: IconList.editPencil),
      ),
    );
  }
}