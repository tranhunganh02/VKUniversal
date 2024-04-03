import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String placeholder;
  final bool isObcurse;
  const LoginTextField(
      {super.key, required this.placeholder, required this.isObcurse});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObcurse,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }
}
