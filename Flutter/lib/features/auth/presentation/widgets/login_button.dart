import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String label;
  const LoginButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(label));
  }
}
