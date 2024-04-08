import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(LucideIcons.chevronLeft),
        ),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
