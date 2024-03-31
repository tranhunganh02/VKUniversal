import 'package:flutter/material.dart';
import 'package:vkuniversal/config/theme/theme_data.dart';

void main() {
  runApp(const VKUniversal());
}

class VKUniversal extends StatefulWidget {
  const VKUniversal({super.key});

  @override
  State<VKUniversal> createState() => _VKUniversalState();
}

class _VKUniversalState extends State<VKUniversal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
