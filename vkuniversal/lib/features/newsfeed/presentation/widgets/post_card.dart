import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    double height = ScreenScale(context: context).getHeight();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      color: colorScheme.surface,
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          // Phần tên người dùng, ngày tháng, nút ba chấm
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/avatar/img_0542.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ngọc Võ",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            "18:10, Ngày 17/03/2024",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.more_outline),
                ),
              ],
            ),
          ),
          // Phần nội dung bài viết
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                Text(
                  "Hôm nay là một ngày đẹp trời.",
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
          // Phần ảnh
          Container(
            child:
                Image.asset("assets/images/background/vku_main_building.jpg"),
          ),
          // Các nút like, cmt,...
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.heart_outline),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.message_2_outline),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.link_outline),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.save_2_outline),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                "Có Nanoo, Ngocvt.21it và những người khác thích bài viết này.",
                overflow: TextOverflow.clip,
                maxLines: 3,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                "Xem tất cả 23 bình luận...",
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          // Bình luận
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.05,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/avatar/img_0542.jpg'),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.04,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: colorScheme.onPrimary)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Thêm bình luận...",
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
