import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/config/routes/routes.dart';
import 'package:vkuniversal/config/theme/theme_const.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/utils/logout_common.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/auth/domain/usecases/check_student_info.dart';
import 'package:vkuniversal/features/auth/domain/usecases/logout.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/add_user_info/bloc/add_user_info_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_in/bloc/sign_in_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/pages/welcome.dart';
import 'package:vkuniversal/features/chat/presentation/bloc/list_chat/list_chat_bloc.dart';
import 'package:vkuniversal/features/chat/presentation/bloc/room_chat/room_chat_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/home/bloc/home_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/newfeeds/bloc/newfeed_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/posts/bloc/create_post_bloc.dart';
import 'package:vkuniversal/features/profile/presentation/state/bloc/profile_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDQtiBswAc9Qn5w_5ePEW_8QJejfDQckqA",
          authDomain: "test1-8afe3.firebaseapp.com",
          databaseURL:
              "https://test1-8afe3-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "test1-8afe3",
          storageBucket: "test1-8afe3.appspot.com",
          messagingSenderId: "282946755124",
          appId: "1:282946755124:web:72318e63f137b77d924861",
          measurementId:
              "G-P1K46FCHN2" // Thông tin khác tùy theo cài đặt Firebase của bạn
          ),
    ); // Khởi tạo bình thường cho các nền tảng khác
  } 
  else if (Platform.isMacOS) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        appId: '1:282946755124:ios:d6beb875136a3a9d924861',
        authDomain: 'test1-8afe3.firebaseapp.com',
        apiKey: 'AIzaSyA3N_V3TcCqwi9y86MStLCywIyC_EUKCFk',
        projectId: 'test1-8afe3',
        messagingSenderId: '282946755124',
        storageBucket:
            'test1-8afe3.appspot.com',
        databaseURL: 'https://test1-8afe3-default-rtdb.asia-southeast1.firebasedatabase.app'    
             // Thông tin khác tùy theo cài đặt Firebase của bạn
      ),
    );
  }
   else  {
    await Firebase.initializeApp();
  }
  await initializeDependencies();
  initializeDateFormatting();
  await setupLocator();
  final prefs = await SharedPreferences.getInstance();
  String? email = await prefs.getString('email');
  String? password = await prefs.getString('password');
  bool isLoggedIn = email != null;

  // final signInWithEmail = sl<SignInWithEmail>();
  // signInWithEmail(data: SignInRequest(email: email!, password: password!));
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
      ),
      BlocProvider(
        create: (_) => sl<ProfileBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<NewfeedBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<CreatePostBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<ListChatBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<RoomChatBloc>(),
      ),
      // BlocProvider(
      //   create: (_) => sl<PostCardBloc>(),
      // ),
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
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
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

    final checkUserInfo = await sl<CheckUserInfoExists>();
    final result = await checkUserInfo(data: SetUpAuthData(prefs));

    
    if (result is DataFailed) {
      LogoutCommon(context);
      //Logout(authRepository: sl());
    } else {
      if (result.data?.isExist == true) {
        await prefs.setBool('hasUserInfo', true);
      } else {
        await prefs.setBool('hasUserInfo', false);
      }

      String? email = prefs.getString('email');
      int? role = prefs.getInt('role');
      bool isLogin = email != null;

      bool hasStudentInfo = prefs.getBool('hasUserInfo') ?? false;

      if (!isLogin) {
        Navigator.pushReplacementNamed(context, RoutesName.welcome);
      } else if (hasStudentInfo || role != 1) {
        Navigator.pushReplacementNamed(context, RoutesName.home);
        Navigator.pushAndRemoveUntil(
            context,
            Routes.generateRoute(RouteSettings(name: RoutesName.home)),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.addUserInfor);
      }
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
