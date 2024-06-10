import 'package:flutter/material.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/stateless_post_card.dart';

class FollowingTab extends StatefulWidget {
  const FollowingTab({super.key});

  @override
  State<FollowingTab> createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 223,
        ),
        child: Column(
          children: [
            StatelessPostCard(),
            StatelessPostCard(),
            StatelessPostCard(),
          ],
        ),
      ),
    );
  }
}
