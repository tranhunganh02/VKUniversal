import 'package:flutter/material.dart';

SizedBox Avatar(String? image, double Size) {
  return SizedBox(
    height: Size,
    width: Size,
    child: CircleAvatar(
      backgroundImage: NetworkImage(image ??
          "https://e7.pngegg.com/pngimages/304/275/png-clipart-user-profile-computer-icons-profile-miscellaneous-logo.png"),
    ),
  );
}
