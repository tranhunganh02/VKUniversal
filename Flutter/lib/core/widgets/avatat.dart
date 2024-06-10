import 'package:flutter/material.dart';

SizedBox Avatar(String? image, double size) {
  return SizedBox(
    height: size,
    width: size,
    child: CircleAvatar(
      backgroundImage: NetworkImage(image ??
          "https://e7.pngegg.com/pngimages/304/275/png-clipart-user-profile-computer-icons-profile-miscellaneous-logo.png"),
    ),
  );
}
