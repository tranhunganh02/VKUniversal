import 'package:flutter/material.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/profile/presentation/pages/image_fake.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    var username = "Ngọc Võ";
    username = username.length > 9 ? username.substring(0, 9) : username;

    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colorScheme.outlineVariant, width: 1),
          ),
        ),
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Post",
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            CustomSizeBox(value: 10),
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
                        child: Image.network(
                          link_image,
                          fit: BoxFit.fill,
                        ),
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
    );
  }
}
