import 'package:flutter/material.dart';
import 'package:vkuniversal/config/routes/router_name.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.popAndPushNamed(context, RoutesName.signUp);
      },
      child: RichText(
        text: TextSpan(
            text: "Don't have an account? ",
            style: textTheme.headlineSmall?.copyWith(color: Color(0xffD0CFD4)),
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
    );
  }
}
