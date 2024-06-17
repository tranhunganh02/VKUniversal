import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/core/utils/show_snack_bar.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/comment/bloc/comment_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/post_detail.dart/bloc/post_detail_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/posts/bloc/create_post_bloc.dart';

class CommentBottomSheet extends StatefulWidget {
  final int postID;
  const CommentBottomSheet({super.key, required this.postID});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet>
    with TickerProviderStateMixin {
  String? avatarUser;
  String? displayName;
  TextEditingController _contentController = TextEditingController();

  // List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _loadDefault();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _loadDefault() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarUser = prefs.getString('avatar');
      displayName = prefs.getString('displayName');
    });
  }

  void SubmitForm() {
    sl<CommentBloc>().add(
      CreateComment(
        postID: widget.postID,
        content: _contentController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CreateCommentSuccess) {
          sl<PostDetailBloc>().add(LoadPostDetail(postID: widget.postID));
        } else if (state is CreatePostFailed) {
          showErrorSnackBar(context, "Something error");
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.outline,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          width: width,
          height: 150,
          child: Column(
            children: [
              Text(
                "Add Comment:",
                style:
                    textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _contentController,
                      keyboardType: TextInputType.multiline,
                      style: textTheme.bodyLarge
                          ?.copyWith(color: colorScheme.secondary),
                      minLines: 1,
                      maxLines:
                          null, // Allows the TextField to grow with content
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Comment as $displayName...',
                        hintStyle: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        SubmitForm();
                      },
                      icon: Icon(Iconsax.send_bulk))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
