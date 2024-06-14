import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/newfeeds/bloc/newfeed_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/post_card.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  void initState() {
    super.initState();
    _loadExplorePosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ProfileModel userModel = ProfileModel(userBio: "", user: sl());
    return RefreshIndicator(
      onRefresh: () async {
        _loadExplorePosts();
      },
      child: BlocBuilder<NewfeedBloc, NewfeedState>(
        builder: (context, state) {
          if (state is NewfeedLoading) {
            return Loader();
          } else if (state is NewfeedLoaded) {
            return Container(
              margin: EdgeInsets.only(bottom: 223),
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    postID: state.posts[index].postID,
                    username: state.posts[index].userName,
                    date: state.posts[index].createdAt,
                    avatar: state.posts[index].avatarUrl,
                    images: state.posts[index].images ?? [],
                    content: state.posts[index].content,
                    likes: state.posts[index].likes,
                    isLiked: state.posts[index].likeByUser,
                  );
                },
              ),
            );
          }
          return Loader();
        },
      ),
    );
  }

  void _loadExplorePosts() {
    // Check if the widget is still mounted before calling setState
    if (mounted) {
      context.read<NewfeedBloc>().add(LoadPosts(page: 1));
    }
  }
}
