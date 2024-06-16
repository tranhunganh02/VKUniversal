import 'package:flutter/material.dart';

import '../../../../core/widgets/avatat.dart';
import '../../../../helper/convert_time.dart';

ListTile TileUserChat(String username, String? last_message, int? time_last_message, TextTheme textTheme, String? image, void Function() navigate) {
  return ListTile(
    title: Text(username),
    subtitle: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Expanded(
          child: Text(
            last_message ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // Truncate the text if it's too long
          ),
        ),
        Text(
          time_last_message != null
            ? formatTimestamp(time_last_message)
            : "",
        ),
      ],
    ),
    leading: Avatar(size: 55, image: image,),

    onTap: navigate,
  );
}
