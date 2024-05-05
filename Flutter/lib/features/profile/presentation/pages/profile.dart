import 'package:flutter/material.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/library.dart';
import 'package:vkuniversal/helper/check_notch_device.dart';

import '../widgets/biography.dart';
import '../widgets/update_button.dart';
import 'image_fake.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    var image =
        "https://s3-alpha-sig.figma.com/img/0e60/c6e9/34cba03d7b6c3f3ee8b602e5690b5184?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cKMHlWGSzBQBlvULxWM0766MtIABf96bIv-yK~u0HCMu6IaxD6nkRG7Lv4iaD2qp4-Znfjb23Ma~cIbQxnPSN9godPmMN6h2E-59uMiWVdUgJk3V3ez9Kl8oHVoDvbQwskGkXb2ZIB0W619iL3vW7drMkxQ4FOeZ1ffmepFzpdMQ3AaL84LI5IqvavSd2oyemj7Xqcd37R9AWxn8VKRIvNMF2yI1C95i7vcyQesy0jKgPdsBRVD~gJJGjr4Bqh0ilNxbM95UKH0qQ-kjZzZWa9ZWr8tb3JSfjAgJOJrtR-BhoH~fUzEpEmgX8gtOdahPP3zPuM6bWKoOO9ukfWkedw__";
    var username = "Ngọc Võ";
    username = username.length > 9 ? username.substring(0, 9) : username;

    String email = "fasfa.21it@gmail.com";
    String date_of_birth = "02/12/1992";
    String class_user = "21SE1";

    //truyen thong tin update vo day
    void navigationToUpdate() {
      Navigator.pushNamed(context, RoutesName.updateProfile);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: 5, top: isNotchDevice(context) ? 25 : 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //dien link avatar
                    Avatar(image, 80),
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //user_name
                            Text(
                              username,
                              style: textTheme.displaySmall
                                  ?.copyWith(color: colorScheme.onSurface),
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            UpdateButton(updateAvate: navigationToUpdate)
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Software Engineer VKU",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () {}, icon: IconList.message),
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                width: widthScreen * 0.3,
                                height: heightScreen * 0.09,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: colorScheme.primaryContainer),
                                child: Center(
                                    child: Text(
                                  "Follow",
                                  style: textTheme.labelLarge,
                                )),
                              )),
                          IconButton(onPressed: () {}, icon: IconList.share)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal:
                        BorderSide(color: colorScheme.outline, width: 1),
                  ),
                ),
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Biography",
                      style: textTheme.bodyLarge
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    BioUser(
                      email: email,
                      date_of_birth: date_of_birth,
                      class_user: class_user,
                    )
                  ],
                ),
              ),
              LibraryWidget(),
              Expanded(
                child: Container(),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
