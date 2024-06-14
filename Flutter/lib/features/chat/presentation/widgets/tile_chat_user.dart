import 'package:flutter/material.dart';

import '../../../../core/widgets/avatat.dart';
import '../../../../helper/convert_time.dart';


ListTile TileUserChat(username, last_message, created_at, TextTheme textTheme, String image, void Function() navigate) {
    return ListTile(
                  title: Text(username),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(last_message),
                      ),
                      Text(
                        formatTimestamp(created_at), // Thời gian nhắn
                        style: textTheme
                            .bodySmall, // Tuỳ chỉnh màu sắc theo nhu cầu
                      ),
                    ],
                  ),
                  leading: Avatar(image, 55),
                  onTap: navigate,
                  
                );
  }