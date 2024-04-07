import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';

class LoginButton extends StatelessWidget {
  final String label;
  const LoginButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenScale(context: context).getWidth() * 0.9,
      height: 50,
      child: FilledButton(
        onPressed: () {},
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color(0xFFEDEDEE).withOpacity(0.5),
        ),
      ),
    );
  }
}
