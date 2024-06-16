import 'package:flutter/material.dart';

class Responsive {
  static bool isMobileMedium(BuildContext context) => MediaQuery.of(context).size.width < 850 &&  MediaQuery.of(context).size.height<667;
  static bool isMobileLarge(BuildContext context) => MediaQuery.of(context).size.width < 850 &&  MediaQuery.of(context).size.height<890;

   static bool isTable(BuildContext context) => MediaQuery.of(context).size.width >= 850 &&  MediaQuery.of(context).size.width <1100;

    static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width > 1100;
}