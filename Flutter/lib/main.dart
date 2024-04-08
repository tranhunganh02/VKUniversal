import 'package:flutter/material.dart';
import 'package:vkuniversal/config/router_name.dart';
import 'package:vkuniversal/config/routes.dart';
import 'package:vkuniversal/config/theme/theme_const.dart';
import 'package:vkuniversal/features/auth/presentation/pages/login.dart';
import 'package:vkuniversal/features/auth/presentation/pages/welcome.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const WelcomePage(),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutesName.welcome,
    );
  }
}
