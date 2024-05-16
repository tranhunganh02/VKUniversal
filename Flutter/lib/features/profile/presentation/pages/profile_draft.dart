import 'package:flutter/material.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
import 'package:vkuniversal/features/profile/presentation/pages/profile_tabs/post_tab.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/biography.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/major_label.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/profile_buttons.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/user_label.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    var image =
        "https://scontent.fdad1-4.fna.fbcdn.net/v/t39.30808-6/427931630_3730941007228005_4002607693884312382_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_ohc=pKahOw0j4ZkQ7kNvgFkW0xf&_nc_ht=scontent.fdad1-4.fna&oh=00_AYBjZPBhQ9i1AfywfNQgXyJ4Bd5mI2kn7eKTsgi5yMHFaQ&oe=664B9F13";
    var username = "Ngọc Huy";

    String email = "fasfa.21it@gmail.com";
    String date_of_birth = "02/12/1992";
    String class_user = "21SE1";

    final tabs = <Widget>[
      Text("Post"),
      Text("Image"),
      Text("Video"),
    ];
    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
        ),
        width: widthScreen,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              children: [
                Container(
                  color: colorScheme.surface,
                  width: widthScreen,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Avatar(image, 80),
                      UserLabel(
                        name: username,
                      ),
                      MajorLabel(),
                      ProfileButtons(),
                    ],
                  ),
                ),
                BioUser(
                  email: email,
                  date_of_birth: date_of_birth,
                  class_user: class_user,
                ),
                Container(
                  width: double.maxFinite,
                  height: 30,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    tabs: tabs,
                    controller: tabController,
                    isScrollable: true,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: heightScreen * 1,
                  child: TabBarView(
                    children: <Widget>[
                      PostTab(),
                      Text(
                        "Image Tab",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      Text(
                        "Video Tab",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                    controller: tabController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
