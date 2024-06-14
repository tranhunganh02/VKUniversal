import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  const Avatar({
    super.key,
    this.imageUrl = 'assets/images/avatar/img_0542.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage(imageUrl),
    );
  }
}
