import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/profile/data/model/department.dart';
import 'package:vkuniversal/features/profile/data/model/lecture.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';
import 'package:vkuniversal/features/profile/data/model/student.dart';
import 'package:vkuniversal/features/profile/presentation/pages/profile_tabs/post_tab.dart';
import 'package:vkuniversal/features/profile/presentation/state/bloc/profile_bloc.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/biography.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/major_label.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/profile_buttons.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/user_label.dart';

class ProfilePage extends StatefulWidget {
  final int? role;
  final int? userIDToLoadProfile;
  const ProfilePage({
    super.key,
    this.role,
    this.userIDToLoadProfile,
  });

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    sl<ProfileBloc>().add(LoadProfile(role: 2, userID: 13));
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    late ProfileModel profileModel;

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
      body: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: sl<ProfileBloc>(),
          listener: (BuildContext context, ProfileState state) {},
          builder: (context, state) {
            if (state is ProfileLoaded) {
              final profile = state.profile;
              final user = profile.user as LectureModel;
              if (profile.user is StudentModel) {}
              return Container(
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
                                name: profile.user.displayName!,
                              ),
                              BioLabel(
                                bioContent: profile.userBio ?? "Not Showing",
                              ),
                              ProfileButtons(),
                            ],
                          ),
                        ),
                        BioUser(
                          email: user.email!,
                          date_of_birth: user.dateOfBirth!,
                          class_user: profile.className ?? "Not Showing",
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
              );
            } else if (state is ProfileLoading) {
              return Loader();
            } else if (state is ProfileFailed) {
              return Center(
                child: Text(
                  state.message,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
