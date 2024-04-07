import 'package:flutter/material.dart';

class CustomSizeBox extends StatelessWidget {
  final double value;
  const CustomSizeBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}
