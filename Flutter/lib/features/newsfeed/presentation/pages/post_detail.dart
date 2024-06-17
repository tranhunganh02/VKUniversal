import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/core/utils/setup_comment.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/post_detail.dart/bloc/post_detail_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/cmt_tree.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/post_card.dart';

class PostDetail extends StatefulWidget {
  final int postID;
  const PostDetail({super.key, required this.postID});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final bloc = sl<PostDetailBloc>();
  @override
  void initState() {
    super.initState();
    // _loadDefault();
  }

  // Future<void> _loadDefault() async {
  //   setState(() {
  //     bloc.add(LoadPostDetail(postID: widget.postID));
  //   });
  // }

  void _refreshPostDetail() {
    if (mounted) {
      context.read<PostDetailBloc>().add(LoadPostDetail(postID: widget.postID));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshPostDetail();
        },
        child: BlocProvider<PostDetailBloc>(
          create: (context) => bloc..add(LoadPostDetail(postID: widget.postID)),
          child: BlocBuilder<PostDetailBloc, PostDetailState>(
            builder: (context, state) {
              if (state is PostDetailLoaded) {
                final post = state.post;
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
                    CmtTree(setUpCommentTree(state.comments)),
                  ],
                );
              } else {
                return Loader();
              }
            },
          ),
        ),
      ),
    );
  }
}
