import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/config/router_name.dart';
import 'package:vkuniversal/config/routes.dart';
import 'package:vkuniversal/config/theme/theme_const.dart';
import 'package:vkuniversal/core/injection_container.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/pages/welcome.dart';

Future<void> main() async {
  await initializeDependencies();
  // runApp(
  //   const MyApp(),
  // );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => sl<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
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
