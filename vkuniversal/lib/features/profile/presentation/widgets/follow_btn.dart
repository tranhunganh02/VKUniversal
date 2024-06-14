import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: () {},
      child: Container(
        width: widthScreen * 0.3,
        height: heightScreen * 0.09,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: colorScheme.primaryContainer),
        child: Center(
            child: Text(
          "Follow",
          style: textTheme.labelLarge,
        )),
      ),
    );
  }
}
