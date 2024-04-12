import 'package:flutter/material.dart';
import 'package:vkuniversal/config/router_name.dart';
import 'package:vkuniversal/config/routes.dart';
import 'package:vkuniversal/core/utils/images_string.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/pages/login.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/login_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/vku_logo.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double logoScale = widthScreen * 0.28;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

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
                    style: textTheme.displayMedium,
                  ),
                  Text(
                    "VKUniversal!",
                    style: textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Connect hearts, creating communicaties",
                    style: textTheme.displaySmall,
                  )
                ],
              ),
              Column(
                children: [
                  LoginButton(
                    label: "Sign in",
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                  ),
                  CustomSizeBox(value: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signUp);
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have account? ",
                          style: textTheme.headlineSmall
                              ?.copyWith(color: colorScheme.primary),
                          children: [
                            TextSpan(
                              text: "Sign up!",
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
