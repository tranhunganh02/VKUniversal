// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vkuniversal/config/routes/router_name.dart';
// import 'package:vkuniversal/core/utils/images_string.dart';
// import 'package:vkuniversal/core/widgets/size_box.dart';
// import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';
// import 'package:vkuniversal/features/auth/presentation/widgets/login_button.dart';
// import 'package:vkuniversal/features/auth/presentation/widgets/vku_logo.dart';

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   void initState() {
//     WelcomeBloc().add(AuthInitial());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     double logoScale = widthScreen * 0.28;
//     TextTheme textTheme = Theme.of(context).textTheme;
//     // ColorScheme colorScheme = Theme.of(context).colorScheme;

//     final _logger = Logger();

//     return Scaffold(
//       body: BlocConsumer<WelcomeBloc, WelcomeState>(
//         listener: (context, state) async {
//           if (state is LoggedIn) {
//             _logger.d("Alo");
//             await Navigator.popAndPushNamed(context, RoutesName.home);
//           }
//         },
//         builder: (context, state) {
//           return Stack(
//             children: [
//               // Background
//               AspectRatio(
//                 aspectRatio: 9 / 16,
//                 child: ShaderMask(
//                   shaderCallback: (bounds) {
//                     return LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Color(0xFF2A498E).withOpacity(0.8),
//                         Color(0xFF3D6BD3).withOpacity(0.8)
//                       ],
//                     ).createShader(bounds);
//                   },
//                   child: Image.asset(
//                     ImageString.vku_landscape,
//                     fit: BoxFit.fitHeight,
//                   ),
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   VkuLogo(
//                     logoScale: logoScale,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Welcome to",
//                         style: textTheme.displaySmall,
//                       ),
//                       Text(
//                         "VKUniversal!",
//                         style: textTheme.displayLarge,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Connect hearts, creating communicaties",
//                         style: textTheme.headlineSmall,
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       LoginButton(
//                         label: "Sign in",
//                         onPressed: () {
//                           Navigator.pushNamed(context, RoutesName.login);
//                         },
//                       ),
//                       CustomSizeBox(value: 10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, RoutesName.signUp);
//                         },
//                         child: RichText(
//                           text: TextSpan(
//                               text: "Don't have account? ",
//                               style: textTheme.headlineSmall,
//                               children: [
//                                 TextSpan(
//                                   text: "Sign up!",
//                                   style: textTheme.headlineSmall?.copyWith(
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ]),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/core/utils/images_string.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/login_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/vku_logo.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    WelcomeBloc().add(AuthInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    final double logoScale = widthScreen * 0.28;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final _logger = Logger();

    return Scaffold(
      body: BlocConsumer<WelcomeBloc, WelcomeState>(
        listener: (context, state) async {
          if (state is LoggedIn) {
            _logger.d("Alo");
            await Navigator.popAndPushNamed(context, RoutesName.home);
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // Background
                  Positioned.fill(
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
                      blendMode: BlendMode.srcATop,
                      child: Image.asset(
                        ImageString.vku_landscape,
                        fit: BoxFit.cover,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          VkuLogo(
                            logoScale: logoScale,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to",
                                style: textTheme.displaySmall,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "VKUniversal!",
                                style: textTheme.displayLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Connect hearts, creating communities",
                                style: textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              LoginButton(
                                label: "Sign in",
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.login);
                                },
                              ),
                              CustomSizeBox(value: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.signUp);
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: textTheme.headlineSmall,
                                    children: [
                                      TextSpan(
                                        text: "Sign up!",
                                        style:
                                            textTheme.headlineSmall?.copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
