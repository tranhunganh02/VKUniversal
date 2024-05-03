import 'package:flutter/material.dart';

class SnackBarCus extends StatelessWidget {
  final String label;
  const SnackBarCus({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(label),
      duration: const Duration(seconds: 2),
    );
  }
}
