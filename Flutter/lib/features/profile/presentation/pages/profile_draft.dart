import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/profile/data/model/department.dart';
import 'package:vkuniversal/features/profile/data/model/lecture.dart';
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
  var roleDefault = GetUserRoleDefault();

  @override
  void initState() {
    super.initState();
    _loadDefault();
  }
  
  Future<void> _loadDefault() async {
    Logger _logger = Logger();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      int roleDefault = widget.role ?? prefs.getInt('role') ?? 2;
      int userIDDefault =
          widget.userIDToLoadProfile ?? prefs.getInt('userID') ?? 14;
      sl<ProfileBloc>()
          .add(LoadProfile(role: roleDefault, userID: userIDDefault));
      _logger.d("${roleDefault} ${userIDDefault}");
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

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
                              Avatar(profile.user.avatar, 80),
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  if (profile.user is DepartmentModel) {
                                    final department =
                                        profile.user as DepartmentModel;
                                    return UserLabel(
                                        name: department.departmentName!);
                                  }
                                  return UserLabel(
                                    name: profile.user.displayName!,
                                  );
                                },
                              ),
                              BioLabel(
                                bioContent: profile.userBio,
                              ),
                              ProfileButtons(),
                            ],
                          ),
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (profile.user is DepartmentModel) {
                              final department =
                                  profile.user as DepartmentModel;
                              return BioUser(
                                email: profile.user.email ?? "Not Showing",
                              );
                            }
                            if (profile.user is LectureModel) {
                              final lecture = profile.user as LectureModel;
                              return BioUser(
                                email: profile.user.email ?? "Not Showing",
                                date_of_birth: lecture.dateOfBirth,
                                faculty_name: lecture.faculty!.name,
                              );
                            }
                            if (profile.user is StudentModel) {
                              final student = profile.user as StudentModel;
                              return BioUser(
                                email: profile.user.email ?? "Not Showing",
                                date_of_birth: student.dateOfBirth,
                                // class_user: ,
                              );
                            } else {
                              return Container();
                            }
                          },
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
