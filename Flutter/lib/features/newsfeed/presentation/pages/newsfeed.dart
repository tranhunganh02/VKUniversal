import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/utils/logout_common.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/features/auth/domain/usecases/logout.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/tabs/explore_tab.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/tabs/following_tab.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/create_post_bottom_sheet.dart';
import 'package:vkuniversal/features/profile/presentation/state/bloc/profile_bloc.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/avatat.dart';

class NewsfeedPage extends StatefulWidget {
  const NewsfeedPage({super.key});

  @override
  State<NewsfeedPage> createState() => _NewsfeedPageState();
}

class _NewsfeedPageState extends State<NewsfeedPage>
    with TickerProviderStateMixin {
  Future<void> _loadDefault() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      int roleDefault = prefs.getInt('role') ?? 2;
      int userIDDefault = prefs.getInt('userID') ?? 14;
      sl<ProfileBloc>()
          .add(LoadProfile(role: roleDefault, userID: userIDDefault));
      logger.d("${roleDefault} ${userIDDefault}");
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDefault();
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    double height = ScreenScale(context: context).getHeight();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    final isDesktop = Responsive.isDesktop(context);
    final isTable = Responsive.isTable(context);
    final isMobileLarge = Responsive.isMobileLarge(context);

    final tabs = <Widget>[
      Text(
        "Explore",
        style: isDesktop || isTable
            ? textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
              )
            : textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
              ),
      ),
      Text(
        "Following",
        style: isDesktop || isTable
            ? textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
              )
            : textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
              ),
      ),
    ];
    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            isDesktop || isTable ? kToolbarHeight + 20 : kTextTabBarHeight),
        child: Padding(
          padding: isDesktop || isTable
              ? EdgeInsets.only(
                  top: 5,
                )
              : EdgeInsets.only(top: 0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              width: width * 0.35,
              child: Image.asset(
                'assets/images/logo/vkuniversal_light.png',
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Iconsax.search_normal_1_outline),
                onPressed: () => LogoutCommon(context),
              ),
              IconButton(
                icon: Icon(Iconsax.notification_outline),
                onPressed: () {},
              ),
            ],
          ),
        ),
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
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoaded) {
                            return Avatar(
                                size: isDesktop || isTable ? 50 : 35,
                                image: state.profile.user.avatar);
                          }
                          return Avatar(
                              size: isDesktop || isTable ? 50 : 35,
                              image: avatarNotFound);
                        },
                      ),
                      GestureDetector(
                        onTap: () => showBottomSheet(
                          context: context,
                          builder: (context) => PostBottomSheet(),
                        ),
                        child: Container(
                          width:  width * 0.8,
                          height: isDesktop || isTable ? 55 : 35,
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
                              style: isDesktop || isTable
                                  ? textTheme.labelMedium?.copyWith(
                                      color: colorScheme.onSurface
                                          .withOpacity(0.5),
                                    )
                                  : textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurface
                                          .withOpacity(0.5),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
