import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/follow_btn.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {}, icon: IconList.message),
          FollowButton(),
          IconButton(onPressed: () {}, icon: IconList.share)
        ],
      ),
    );
  }
}
