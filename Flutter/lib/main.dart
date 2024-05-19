import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/config/routes/routes.dart';
import 'package:vkuniversal/config/theme/theme_const.dart';
import 'package:vkuniversal/core/constants/refresh_token.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/usecases/check_student_info.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/add_user_info/bloc/add_user_info_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_in/bloc/sign_in_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/pages/add_user_info.dart';
import 'package:vkuniversal/features/auth/presentation/pages/welcome.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/home.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/newsfeed.dart';
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
      ),
      BlocProvider(
        create: (_) => sl<AddUserInfoBloc>(),
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
      home: isLoggedIn ? CheckUserState() : WelcomePage(),
      // home: CheckUserState(),
      // home: AddUserInfoPage(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

class CheckUserState extends StatefulWidget {
  const CheckUserState({super.key});

  @override
  State<CheckUserState> createState() => _CheckUserStateState();
}

class _CheckUserStateState extends State<CheckUserState> {
  @override
  Widget build(BuildContext context) {
    return Loader();
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushReplacementNamed(context, RoutesName.noInternet);
    } else {
      _checkStudentState();
    }
  }

  Future<void> _checkStudentState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // final checkUser = sl<CheckUserInfoExists>();

    String? email = prefs.getString('email');
    bool isLogin = email != null;

    // final authorization = SetUpAuthData(prefs);

    // final _response = await checkUser(data: authorization);

    // if (_response is DataSuccess) {
    //   prefs.setBool('hasUserInfo', _response.data!.isExist);
    // } else {
    //   RefreshTokenCommon(prefs);
    //   final _response = await checkUser(data: authorization);
    //   if (_response is DataSuccess) {
    //     prefs.setBool('hasUserInfo', _response.data!.isExist);
    //   }
    // }

    bool hasStudentInfo = prefs.getBool('hasUserInfo') ?? false;

    if (!isLogin) {
      Navigator.pushReplacementNamed(context, RoutesName.welcome);
    } else if (hasStudentInfo) {
      Navigator.pushReplacementNamed(context, RoutesName.home);
    } else {
      Navigator.pushReplacementNamed(context, RoutesName.addUserInfor);
    }
  }
}

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Loader(),
      ),
    );
  }
}
