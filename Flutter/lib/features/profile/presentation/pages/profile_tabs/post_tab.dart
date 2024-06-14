import 'package:flutter/material.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/stateless_post_card.dart';

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: SingleChildScrollView(
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
