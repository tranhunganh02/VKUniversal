import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final int postID;
  const PostDetail({super.key, required this.postID});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold();
  }
}
