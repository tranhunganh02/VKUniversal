import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vkuniversal/core/utils/date_converter.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/newfeeds/bloc/newfeed_bloc.dart';

class PostCardWithoutImage extends StatefulWidget {
  final String username;
  final String date;
  final String avatar;
  final String? content;
  final int likes;
  final bool isLiked;
  const PostCardWithoutImage(
      {super.key,
      required this.username,
      required this.date,
      required this.avatar,
      this.content,
      required this.likes,
      required this.isLiked});

  @override
  State<PostCardWithoutImage> createState() => _PostCardWithoutImageState();
}

class _PostCardWithoutImageState extends State<PostCardWithoutImage> {
  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    double height = ScreenScale(context: context).getHeight();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    DateConverter dateConverter = convertDate(widget.date);

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
                      backgroundImage: NetworkImage(widget.avatar),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.username}",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            dateConverter.formattedTime +
                                ", Ngày " +
                                dateConverter.formattedDay,
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
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: widget.content ?? "",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Các nút like, cmt,...
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BlocBuilder<NewfeedBloc, NewfeedState>(
                      builder: (context, state) {
                        if (state is NewfeedLoaded && widget.isLiked) {
                          return IconButton(
                            onPressed: () {},
                            icon: Icon(Iconsax.heart_bold),
                          );
                        }
                        return IconButton(
                          onPressed: () {},
                          icon: Icon(Iconsax.heart_outline),
                        );
                      },
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
              child: widget.likes != 0
                  ? Text(
                      widget.likes.toString() + " likes",
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    )
                  : Container(),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                "Xem bình luận...",
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
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: colorScheme.surfaceContainer)),
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
