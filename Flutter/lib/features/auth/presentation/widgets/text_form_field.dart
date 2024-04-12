import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final ImageIcon? imageIcon;
  final bool isObscured;
  AuthTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.imageIcon,
    required this.isObscured,
  });

  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: width * 0.9,
      height: 52,
      child: TextFormField(
        obscureText: isObscured,
        style: textTheme.labelSmall,
        cursorColor: colorScheme.onPrimary,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: textTheme.labelSmall,
          fillColor: colorScheme.secondary,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(
                10), // Transparent border for unfocused state
          ),
        ),
      ),
    );
  }
}
