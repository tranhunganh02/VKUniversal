import 'package:flutter/material.dart';
import 'package:vkuniversal/config/router_name.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/circle_check_box.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/filled_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/google_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/horizontal_line.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      body: Center(
        child: Column(
          children: [
            Text(
              "Register",
              style: textTheme.headlineLarge,
            ),
            CustomSizeBox(value: 10),
            Text(
              "Create your new account",
              style: textTheme.headlineSmall,
            ),
            CustomSizeBox(value: 50),
            AuthTextField(
              hintText: "Name",
              prefixIcon: IconList.user,
              isObscured: false,
            ),
            CustomSizeBox(value: 10),
            AuthTextField(
              hintText: "Email",
              prefixIcon: IconList.email,
              isObscured: false,
            ),
            CustomSizeBox(value: 10),
            AuthTextField(
              hintText: "Password",
              prefixIcon: IconList.lock,
              isObscured: true,
            ),
            CustomSizeBox(value: 10),
            CircleCheckBox(
              label: 'Remember me?',
              value: false,
            ),
            FilledButtonCustom(
              label: "Create",
              onPress: () {},
            ),
            CustomSizeBox(value: 10),
            HorizontalLine(),
            GoogleButton(
              label: 'Sign up with Google',
              onPressed: () {},
            ),
            CustomSizeBox(value: 10),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, RoutesName.login);
              },
              child: RichText(
                text: TextSpan(
                    text: "Already have an account? ",
                    style: textTheme.headlineSmall
                        ?.copyWith(color: Color(0xffD0CFD4)),
                    children: [
                      TextSpan(
                        text: "Sign in",
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primaryContainer,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
