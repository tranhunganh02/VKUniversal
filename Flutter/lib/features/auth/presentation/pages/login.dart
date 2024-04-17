import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/config/router_name.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/circle_check_box.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/filled_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/google_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/horizontal_line.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: IconList.backArrow,
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              "Welcome back",
              style: textTheme.headlineLarge,
            ),
            CustomSizeBox(value: 10),
            Text(
              "Login to your account",
              style: textTheme.headlineSmall,
            ),
            CustomSizeBox(value: 50),
            AuthTextField(
              hintText: "Email",
              prefixIcon: IconList.email,
              isObscured: false,
              controller: emailController,
            ),
            CustomSizeBox(value: 10),
            AuthTextField(
              hintText: "Password",
              prefixIcon: IconList.lock,
              isObscured: true,
              controller: passwordController,
            ),
            CustomSizeBox(value: 10),
            CircleCheckBox(
              label: 'Remember me?',
              value: false,
            ),
            FilledButtonCustom(
              label: "Login",
              onPress: () {},
            ),
            CustomSizeBox(value: 10),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, RoutesName.signUp);
              },
              child: RichText(
                text: TextSpan(
                    text: "Don't have an account? ",
                    style: textTheme.headlineSmall
                        ?.copyWith(color: Color(0xffD0CFD4)),
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primaryContainer,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
              ),
            ),
            CustomSizeBox(value: 10),
            Text(
              "Or",
              style:
                  textTheme.headlineSmall?.copyWith(color: Color(0xffD0CFD4)),
            ),
            GoogleButton(
              label: 'Sign up with Google',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
