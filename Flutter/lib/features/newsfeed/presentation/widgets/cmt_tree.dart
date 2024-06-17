import 'package:flutter/material.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/features/newsfeed/data/model/cmt_tree_model.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/comment_bottom_sheet.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/create_post_bottom_sheet.dart';

class CmtTree extends StatelessWidget {
  final List<CmtTreeModel> comments;

  CmtTree(this.comments);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: ScreenScale(context: context).getWidth(),
      height: ScreenScale(context: context).getHeight(),
      child: comments.length > 0
          ? ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    width: 40,
                                    height: 40,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(avatarNotFound),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: ScreenScale(context: context)
                                              .getWidth() *
                                          0.6,
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: colorScheme.outline,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              comments[index]
                                                  .node
                                                  .userName
                                                  .toString(),
                                              style:
                                                  textTheme.bodySmall?.copyWith(
                                                color: colorScheme.onSurface,
                                              )),
                                          Text(
                                            comments[index].node.content,
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        colorScheme.onSurface),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => showBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            CommentBottomSheet(
                                          postID: comments[index].node.postID,
                                        ),
                                      ),
                                      child: Text("Reply",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: colorScheme.onSurface)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    comments[index].children.length > 0
                        ? ListTile(
                            title: Container(
                              width: ScreenScale(context: context).getWidth(),
                              height: 70,
                              child: ListView.builder(
                                  itemCount: comments[index].children.length,
                                  itemBuilder: (context, index2) {
                                    return ListTile(
                                      title: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    width: 40,
                                                    height: 40,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(comments[
                                                                      index]
                                                                  .node
                                                                  .avatar ??
                                                              avatarNotFound),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: ScreenScale(
                                                              context: context)
                                                          .getWidth() *
                                                      0.6,
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          colorScheme.outline,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        comments[index]
                                                            .children[index2]
                                                            .node
                                                            .userName
                                                            .toString(),
                                                      ),
                                                      Text(
                                                        comments[index]
                                                            .children[index2]
                                                            .node
                                                            .content,
                                                        style: textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: colorScheme
                                                                    .onSurface),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : Container(),
                  ],
                );
              })
          : Container(),
    );
  }
}
