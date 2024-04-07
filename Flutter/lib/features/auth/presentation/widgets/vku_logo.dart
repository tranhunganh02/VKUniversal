import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/images_string.dart';

class VkuLogo extends StatelessWidget {
  final double logoScale;
  const VkuLogo({super.key, required this.logoScale});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: logoScale,
        height: logoScale,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Image.asset(
          ImageString.vku_logo,
        ),
      ),
    );
  }
}
