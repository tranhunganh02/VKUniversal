import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? image;
  final double size;

  const Avatar( {
    Key? key,
    this.image,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircleAvatar(
        backgroundImage: NetworkImage(image ??
            "https://e7.pngegg.com/pngimages/304/275/png-clipart-user-profile-computer-icons-profile-miscellaneous-logo.png"),
      ),
    );
  }
}
