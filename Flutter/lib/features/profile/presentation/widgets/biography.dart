import 'package:flutter/material.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';

import '../../../../core/utils/icon_string.dart';

class BioUser extends StatelessWidget {
  final String email;
  final String date_of_birth;
  final String class_user;
  const BioUser(
      {super.key,
      required this.email,
      required this.date_of_birth,
      required this.class_user});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surface,
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Biography",
              style:
                  textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
            ),
            Row(
              children: [
                IconList.email,
                SizedBox(
                  width: 20,
                ),
                Text(
                  email,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onSurface),
                ),
              ],
            ),
            CustomSizeBox(value: 10),
            Row(
              children: [
                IconList.calender,
                SizedBox(
                  width: 20,
                ),
                Text(
                  date_of_birth,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            CustomSizeBox(value: 10),
            Row(
              children: [
                IconList.graduationCap,
                SizedBox(
                  width: 20,
                ),
                Text(
                  class_user,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
