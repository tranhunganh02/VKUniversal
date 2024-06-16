import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/newfeeds/bloc/newfeed_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/widgets/post_card.dart';

import '../../../../../core/utils/responsive.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  int page = 1;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadExplorePosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ProfileModel userModel = ProfileModel(userBio: "", user: sl());

    final isDesktop = Responsive.isDesktop(context);
    final isTable = Responsive.isTable(context);
    final isMobileLarge = Responsive.isMobileLarge(context);

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
              padding: isDesktop||isTable? EdgeInsets.symmetric(horizontal: 200): null,
              margin: EdgeInsets.only(bottom: 223),
              child: ListView.builder(
                controller: _scrollController,
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

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      page++;
      _loadMorePosts();
    }
  }

  void _loadMorePosts() {
    if (mounted) {
      final currentState = context.read<NewfeedBloc>().state;
      if (currentState is NewfeedLoaded) {
        context.read<NewfeedBloc>().add(LoadMorePosts(page: page));
      }
    }
  }
}
