import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/newfeeds/bloc/newfeed_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/post_card.dart';

class PostDetail extends StatefulWidget {
  final int postID;
  const PostDetail({super.key, required this.postID});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  void initState() {
    super.initState();
    _loadDefault();
  }

  Future<void> _loadDefault() async {
    setState(() {
      if (mounted) {
        sl<NewfeedBloc>().add(LoadPostDetail(postID: widget.postID));
      }
    });
  }

  void _refreshPostDetail() {
    if (mounted) {
      sl<NewfeedBloc>().add(LoadPostDetail(postID: widget.postID));
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshPostDetail;
        },
        child: BlocBuilder<NewfeedBloc, NewfeedState>(
          builder: (context, state) {
            if (state is NewfeedLoaded) {
              final post = state.posts
                  .firstWhere((post) => post.postID == widget.postID);
              return ListView(
                children: [
                  PostCard(
                    username: post.userName,
                    content: post.content,
                    date: post.createdAt,
                    avatar: post.avatarUrl,
                    images: post.images ?? [],
                    likes: post.likes,
                    isLiked: post.likeByUser,
                    postID: post.postID,
                    userID: post.userID,
                    role: post.role ?? 0,
                  ),
                ],
              );
            } else {
              return Loader();
            }
          },
        ),
      ),
    );
  }
}
