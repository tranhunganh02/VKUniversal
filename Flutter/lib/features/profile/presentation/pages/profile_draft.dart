import 'package:flutter/material.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/post_card.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/biography.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/library.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/major_label.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/profile_buttons.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/user_label.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    var image =
        "https://s3-alpha-sig.figma.com/img/0e60/c6e9/34cba03d7b6c3f3ee8b602e5690b5184?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cKMHlWGSzBQBlvULxWM0766MtIABf96bIv-yK~u0HCMu6IaxD6nkRG7Lv4iaD2qp4-Znfjb23Ma~cIbQxnPSN9godPmMN6h2E-59uMiWVdUgJk3V3ez9Kl8oHVoDvbQwskGkXb2ZIB0W619iL3vW7drMkxQ4FOeZ1ffmepFzpdMQ3AaL84LI5IqvavSd2oyemj7Xqcd37R9AWxn8VKRIvNMF2yI1C95i7vcyQesy0jKgPdsBRVD~gJJGjr4Bqh0ilNxbM95UKH0qQ-kjZzZWa9ZWr8tb3JSfjAgJOJrtR-BhoH~fUzEpEmgX8gtOdahPP3zPuM6bWKoOO9ukfWkedw__";
    var username = "Ngọc Võ";

    String email = "fasfa.21it@gmail.com";
    String date_of_birth = "02/12/1992";
    String class_user = "21SE1";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
        ),
        width: widthScreen,
        child: SingleChildScrollView(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
