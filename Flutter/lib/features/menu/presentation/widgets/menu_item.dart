import 'package:flutter/widgets.dart';

class MenuItem {
  final Icon icon;
  final String title;
  final Function onTapFunction;

  MenuItem(
      {required this.icon, required this.title, required this.onTapFunction});
}
