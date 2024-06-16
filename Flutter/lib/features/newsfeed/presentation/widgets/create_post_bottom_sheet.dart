import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/core/utils/show_snack_bar.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/posts/bloc/create_post_bloc.dart';

class PostBottomSheet extends StatefulWidget {
  const PostBottomSheet({super.key});

  @override
  State<PostBottomSheet> createState() => _PostBottomSheetState();
}

class _PostBottomSheetState extends State<PostBottomSheet>
    with TickerProviderStateMixin {
  String? avatarUser;
  String? displayName;
  TextEditingController _contentController = TextEditingController();

  List<File> _images = [];

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

  @override
  Widget build(BuildContext context) {
    double width = ScreenScale(context: context).getWidth();
    // double height = ScreenScale(context: context).getHeight();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + 40),
            
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: AppBar(
                 automaticallyImplyLeading: false,
                 
                leading: Container(
                  width: 35,
                  height: 35,
              
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surface.withOpacity(0.75),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: IconList.backArrow,
                    tooltip: "Close",
                  ),
                ),
                title: Container(
                  child: Text(
                    'Create Post',
                    style:
                        textTheme.displaySmall!.copyWith(color: colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: [
                  BlocBuilder<CreatePostBloc, CreatePostState>(
                    builder: (context, state) {
                      if (state is CreatePostLoading) {
                        return TextButton(
                          onPressed: null,
                          child: Text('Post'),
                        );
                      }
                      return TextButton(
                        onPressed: _post,
                        child: Text('Post'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: BlocConsumer<CreatePostBloc, CreatePostState>(
              listener: (context, state) {
                if (state is CreatePostSuccess) {
                  Navigator.pop(context);
                } else if (state is CreatePostFailed) {
                  showErrorSnackBar(
                    context,
                    state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is CreatePostLoading) {
                  return Loader();
                }
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    NetworkImage(avatarUser ?? avatarNotFound)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayName ?? "Not showing",
                                    style: textTheme.bodyLarge!
                                        .copyWith(color: colorScheme.onSurface),
                                  ),
                                  Text(
                                    "Public",
                                    style: textTheme.bodySmall!
                                        .copyWith(color: colorScheme.onSurface),
                                  ),
                                ],
                              ),
                            )
                          ],
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
                                  border: InputBorder.none,
                                  hintText: 'What\'s on your mind?',
                                  hintStyle: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        _images.isNotEmpty
                            ? Flexible(
                                child: ListView.builder(
                                    itemCount: _images.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: Key(_images[index].path),
                                        onDismissed: (direction) {
                                          setState(() {
                                            _images.removeAt(
                                                index); // Remove the item from the list
                                          });
                                        },
                                        child: Container(
                                          width: width,
                                          height: width,
                                          child: Image.file(
                                            _images[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : Text(
                                "No images selected",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                        _images.isNotEmpty
                            ? Text(
                                "! Swipe to remove image",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              )
                            : Container(),
                        ElevatedButton(
                          onPressed: _pickImageFromGallery,
                          child: Text(
                            'Add images',
                            style: textTheme.labelSmall
                                ?.copyWith(color: colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      enableDrag: true,
      animationController: BottomSheet.createAnimationController(this),
    );
  }

  Future<void> _pickImageFromGallery() async {
    await _requestPermissions();
    final List<XFile> images = await ImagePicker().pickMultiImage();
    logger.d("At _pickImageFromGallery: ${images.length} images selected");
    if (images.isEmpty) return;
    setState(() {
      _images.addAll(images.map((image) => File(image.path)));
      logger.d("At _pickImageFromGallery: ${_images.length} images selected");
    });
  }

  void _post() {
    context.read<CreatePostBloc>().add(
          SubmitPost(content: _contentController.text, images: _images),
        );
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }
}
