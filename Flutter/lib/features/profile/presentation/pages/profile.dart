import 'package:flutter/material.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/library.dart';
import 'package:vkuniversal/helper/check_notch_device.dart';

import '../../../../core/utils/responsive.dart';
import '../widgets/biography.dart';
import '../widgets/update_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;


    final isDesktop = Responsive.isDesktop(context);
    final isTable = Responsive.isTable(context);
    final isMobileLarge = Responsive.isMobileLarge(context);

    var image =
        "https://scontent.fdad1-4.fna.fbcdn.net/v/t39.30808-6/427931630_3730941007228005_4002607693884312382_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_ohc=pKahOw0j4ZkQ7kNvgFkW0xf&_nc_ht=scontent.fdad1-4.fna&oh=00_AYBjZPBhQ9i1AfywfNQgXyJ4Bd5mI2kn7eKTsgi5yMHFaQ&oe=664B9F13";
    var username = "Huy Ngọc Trần";
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
                    Avatar(image:image, size: 80),
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
                                height:isDesktop? heightScreen*0.02 : heightScreen * 0.09,
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
              BioUser(
                email: email,
                class_user: class_user,
                date_of_birth: date_of_birth,
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
