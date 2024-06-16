import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/config/routes/routes.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/utils/date_converter.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/newsfeed/data/model/attachment.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/newfeeds/bloc/newfeed_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/create_post_bottom_sheet.dart';

import '../../../../core/utils/responsive.dart';

class PostCard extends StatefulWidget {
  final int postID;
  final String username;
  final String date;
  final String avatar;
  final String? content;
  final List<Attachment> images;
  final int likes;
  final bool isLiked;

  const PostCard({
    super.key,
    required this.username,
    required this.date,
    required this.avatar,
    this.content,
    required this.images,
    required this.likes,
    required this.isLiked,
    required this.postID,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String? avatarUser;
  Future<void> _loadDefault() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarUser = prefs.getString('avatar');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDefault();
  }

  void _likePost(bool isLiked, int index) {
    context.read<NewfeedBloc>().add(
          LikePressed(
            isLiked: isLiked,
            postID: widget.postID,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    double height = ScreenScale(context: context).getHeight();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    DateConverter dateConverter = convertDate(widget.date);


    final isDesktop = Responsive.isDesktop(context);
    final isTable = Responsive.isTable(context);
    final isMobileLarge = Responsive.isMobileLarge(context);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RoutesName.postDetail,
          arguments: PostDetailArguments(widget.postID)),
      child: Container(
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
                                  ", " +
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
                    child: ExpandableText(
                      widget.content ?? "",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 5,
                      expandText: "Show more...",
                      collapseText: "Show less...",
                    ),
                  )
                ],
              ),
            ),
            // Phần ảnh
            // [NOTE: Mỗi list images đề có trả về một phần từ null nên phải check từ 2]
            widget.images.length >= 1
                ? Padding(
                  padding: const EdgeInsets.all(2),
                  child: CarouselSlider(
                      items: widget.images.map((attachment) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              child: Image.network(
                                attachment.fileURL,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Loader();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox();
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: widget.images.isNotEmpty ? isDesktop||isTable ? width*0.38 : width: 0,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        aspectRatio: 1 / 1,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 2000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                      ),
                    ),
                )
                : Container(),
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
                              onPressed: () => _likePost(true, widget.postID),
                              icon: Icon(Iconsax.heart_bold),
                            );
                          }
                          return IconButton(
                            onPressed: () => _likePost(false, widget.postID),
                            icon: Icon(Iconsax.heart_outline),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () => showBottomSheet(
                          context: context,
                          builder: (context) => PostBottomSheet(),
                        ),
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
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding:  EdgeInsets.only(left: 8, right: 8),
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
              padding: isDesktop||isTable ? EdgeInsets.symmetric(horizontal: 15)  :  EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Avatar(size: isTable|| isDesktop ? 50: 35),
                  Container(
                    width: isTable||isDesktop? width*0.64: width * 0.82,
                    height: height * 0.04,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(20.0),
                        border:
                            Border.all(color: colorScheme.surfaceContainer)),
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
      ),
    );
  }
}
