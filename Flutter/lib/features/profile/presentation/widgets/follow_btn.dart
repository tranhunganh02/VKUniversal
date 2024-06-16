import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    final isDesktop = Responsive.isDesktop(context);
    final isTable = Responsive.isTable(context);
    final isMobileLarge = Responsive.isMobileLarge(context);

    return TextButton(
      onPressed: () {},
      child: Container(
        width:isDesktop||isTable? widthScreen*0.28 : widthScreen * 0.3,
        height: isDesktop||isTable? heightScreen * 0.05 : heightScreen * 0.09,
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
