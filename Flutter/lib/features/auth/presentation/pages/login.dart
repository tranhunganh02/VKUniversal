import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vkuniversal/core/utils/images_string.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/login_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // double heightScreen = MediaQuery.of(context).size.height;
    double logoScale = widthScreen * 0.2;

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    return Scaffold(
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 9 / 16,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2A498E).withOpacity(0.8),
                    Color(0xFF3D6BD3).withOpacity(0.8)
                  ],
                ).createShader(bounds);
              },
              child: Image.asset(
                ImageString.vku_landscape,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  width: logoScale,
                  height: logoScale,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    ImageString.vku_logo,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Welcome to VKUniversal!",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Connect hearts, creating communicaties",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  LoginTextField(placeholder: "Email", isObcurse: false),
                  SizedBox(
                    height: 20,
                  ),
                  LoginTextField(placeholder: "Password", isObcurse: true),
                  SizedBox(
                    height: 20,
                  ),
                  LoginButton(
                    label: "Login",
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
