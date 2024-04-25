import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/post_card.dart';

class NewsfeedPage extends StatefulWidget {
  const NewsfeedPage({super.key});

  @override
  State<NewsfeedPage> createState() => _NewsfeedPageState();
}

class _NewsfeedPageState extends State<NewsfeedPage> {
  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: SizedBox(
          width: width * 0.35,
          child: Image.asset(
            'assets/images/logo/vkuniversal_light.png',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.search_normal_1_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Iconsax.notification_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: colorScheme.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/avatar/img_0542.jpg'),
                    ),
                    Container(
                      width: width * 0.8,
                      height: 35,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(20.0),
                          border:
                              Border.all(color: colorScheme.surfaceContainer)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Text(
                          "What's is your mind?",
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PostCard(),
              PostCard(),
            ],
          ),
        ),
      ),
    );
  }
}
