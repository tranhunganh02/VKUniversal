import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BNBIcon extends StatelessWidget {
  final bool isSelected;
  final SvgPicture selectedIcon;
  final SvgPicture unSelectedIcon;
  final double width;
  const BNBIcon(
      {super.key,
      required this.selectedIcon,
      required this.unSelectedIcon,
      required this.width,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isSelected ? unSelectedIcon : selectedIcon,
      width: width * 0.1,
    );
  }
}
