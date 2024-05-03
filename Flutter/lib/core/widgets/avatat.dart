import 'package:flutter/material.dart';

SizedBox Avatar(String image, double Size) {
  return SizedBox(
    height: Size,
    width: Size,
    child: CircleAvatar(
      backgroundImage: NetworkImage(image),
    ),
  );
}
