import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/tabs/explore_tab.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/tabs/following_tab.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/create_post_bottom_sheet.dart';

class NewsfeedPage extends StatefulWidget {
  const NewsfeedPage({super.key});

  @override
  State<NewsfeedPage> createState() => _NewsfeedPageState();
}

class _NewsfeedPageState extends State<NewsfeedPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    double height = ScreenScale(context: context).getHeight();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    final tabs = <Widget>[
      Text(
        "Explore",
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
      Text(
        "Following",
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
    ];
    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
          ),
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
                    GestureDetector(
                      onTap: () => showBottomSheet(
                        context: context,
                        builder: (context) => PostBottomSheet(),
                      ),
                      child: Container(
                        width: width * 0.8,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: colorScheme.surfaceContainer)),
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
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: height * 0.07,
                child: TabBar(
                  tabs: tabs,
                  controller: tabController,
                  isScrollable: false,
                ),
              ),
              Container(
                width: double.maxFinite,
                height: height * 1,
                child: TabBarView(
                  children: <Widget>[
                    ExploreTab(),
                    FollowingTab(),
                  ],
                  controller: tabController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
