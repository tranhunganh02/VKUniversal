import 'package:flutter/material.dart';

class CustomSizeBox extends StatelessWidget {
  final double value;
  double? widthValue;
  CustomSizeBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
      width: widthValue,
    );
  }
}
