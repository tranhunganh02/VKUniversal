import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/images_string.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/login_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/vku_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double logoScale = widthScreen * 0.28;

    return Scaffold(
      body: Stack(
        children: [
          // Background
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
              VkuLogo(
                logoScale: logoScale,
              ),
              Column(
                children: [
                  Text(
                    "Welcome to",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "VKUniversal!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Connect hearts, creating communicaties",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              Column(
                children: [
                  LoginButton(
                    label: "Login",
                  ),
                  CustomSizeBox(value: 10),
                  LoginButton(
                    label: "Sign up",
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
