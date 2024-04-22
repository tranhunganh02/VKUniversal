import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/config/routes/routes.dart';
import 'package:vkuniversal/config/theme/theme_const.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_in/bloc/sign_in_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/newsfeed.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => sl<SignUpBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<SignInBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<WelcomeBloc>(),
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
      home: NewsfeedPage(),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutesName.welcome,
    );
  }
}
