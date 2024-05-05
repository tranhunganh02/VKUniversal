import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/config/routes/routes.dart';
import 'package:vkuniversal/config/theme/theme_const.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_in/bloc/sign_in_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/pages/welcome.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/home.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/home/bloc/home_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  initializeDateFormatting();
  final prefs = await SharedPreferences.getInstance();
  String? email = await prefs.getString('email');
  bool isLoggedIn = email != null;
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
      ),
      BlocProvider(
        create: (_) => sl<BottomNavigationBloc>(),
      )
    ],
    child: MyApp(
      isLoggedIn: isLoggedIn,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyThemeData.lightTheme,
      home: this.isLoggedIn ? Home() : WelcomePage(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
