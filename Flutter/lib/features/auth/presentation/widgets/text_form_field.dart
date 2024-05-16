import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final ImageIcon? imageIcon;
  final bool isObscured;
  final TextEditingController controller;
  final String? validation;
  AuthTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.imageIcon,
    required this.isObscured,
    required this.controller,
    this.validation,
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
        controller: controller,
        obscureText: isObscured,
        style: textTheme.labelMedium?.copyWith(color: colorScheme.secondary),
        cursorColor: colorScheme.secondary,
        validator: (_) => validation,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: textTheme.labelSmall?.copyWith(
            color: colorScheme.secondary,
          ),
          fillColor: colorScheme.onSecondary,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
