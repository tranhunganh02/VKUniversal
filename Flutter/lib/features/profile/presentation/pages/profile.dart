import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
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

    var image =
        "https://s3-alpha-sig.figma.com/img/0e60/c6e9/34cba03d7b6c3f3ee8b602e5690b5184?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cKMHlWGSzBQBlvULxWM0766MtIABf96bIv-yK~u0HCMu6IaxD6nkRG7Lv4iaD2qp4-Znfjb23Ma~cIbQxnPSN9godPmMN6h2E-59uMiWVdUgJk3V3ez9Kl8oHVoDvbQwskGkXb2ZIB0W619iL3vW7drMkxQ4FOeZ1ffmepFzpdMQ3AaL84LI5IqvavSd2oyemj7Xqcd37R9AWxn8VKRIvNMF2yI1C95i7vcyQesy0jKgPdsBRVD~gJJGjr4Bqh0ilNxbM95UKH0qQ-kjZzZWa9ZWr8tb3JSfjAgJOJrtR-BhoH~fUzEpEmgX8gtOdahPP3zPuM6bWKoOO9ukfWkedw__";
    TextTheme textTheme = Theme.of(context).textTheme;
    var username = "Ngoc beso";
    username = username.length > 9 ? username.substring(0, 9) : username;

    String email = "fasfa.21it@gmail.com";
    String date_of_birth = "02/12/1992";
    String class_user = "34SE1";

    //truyen thong tin update vo day
    void navigationToUpdate() {
      Navigator.pushNamed(context, RoutesName.updateProfile);
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: 5, top: isNotchDevice(context) ? 25 : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //dien link avatar
                  Avatar(image, 95),
                  FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //user_name
                            Text(
                              username,
                              style: textTheme.displayMedium,
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            update_button(updateAvate: navigationToUpdate)
                          ],
                        ),
                      )),
                  Text("Major here"),
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
                                      BorderRadius.all(Radius.circular(40)),
                                  color: Colors.blue),
                              child: Center(child: Text("Follow")),
                            )),
                        IconButton(onPressed: () {}, icon: IconList.share)
                      ],
                    ),
                  )
                ],
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey, width: 1)),
              ),
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Biography"),
                  BioUser(email, textTheme, date_of_birth, class_user)
                ],
              ),
            ),
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            
                children: [
                  Text(
                    "post",
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,

                        //check so luong anh > 3
                        itemCount: images.length > 3
                            ? 3
                            : images.length, // Số lượng mục trong ListView
                        itemBuilder: (BuildContext context, int index) {
                          var link_image = images[index]["file_url"];
                          var id = images[index]["attachment_id"];
                          if (index < 2) {
                            return Container(
                              height: double.maxFinite,
                              width: widthScreen * 0.3,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.network(link_image, fit: BoxFit.fill,),
                            );
                          } else
                            return Container(
                              height: double.maxFinite,
                              width: widthScreen * 0.3,
                              color: Colors.grey,
                              child: TextButton(
                                onPressed: () {
                                  // Xử lý khi nhấn vào nút "See All"
                                  print('See All');
                                },
                                child: Text(
                                  'See All (${images.length - index}) +',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                        },
                      ),
                    ),
                  ),
                  //neu images > 2 thi hien thi nut see all
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
            flex: 1,
          )
        ],
      ),
    );
  }
}
