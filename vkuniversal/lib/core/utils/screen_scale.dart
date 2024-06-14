import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenScale {
  final BuildContext context;

  ScreenScale({required this.context});

  double getWidth() {
    return MediaQuery.of(context).size.width;
  }

  double getHeight() {
    return MediaQuery.of(context).size.height;
  }
}
