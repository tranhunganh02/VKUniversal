import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/avatar.dart';

class PostBottomSheet extends StatefulWidget {
  const PostBottomSheet({super.key});

  @override
  State<PostBottomSheet> createState() => _PostBottomSheetState();
}

class _PostBottomSheetState extends State<PostBottomSheet> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surface.withOpacity(0.75),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: IconList.x_close,
                tooltip: "Close",
              ),
            ),
            title: Text(
              'Create Post',
              style:
                  textTheme.displaySmall!.copyWith(color: colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text('Post'),
              ),
            ],
          ),
          body: Container(
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }
}
