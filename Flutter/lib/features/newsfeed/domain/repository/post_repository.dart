import 'dart:io';

import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/post.dart';

abstract class PostRepository {
  Future<DataState<List<PostEntity>>> getPosts({
    required int userID,
    required String accessToken,
    required PageRequest page,
  });
  Future<DataState<void>> LikeThePost({
    required int userID,
    required String accessToken,
    required int postID,
  });
  Future<DataState<void>> UnlikeThePost({
    required int userID,
    required String accessToken,
    required int postID,
  });
  Future<DataState<void>> CreatePost({
    required int userID,
    required String accessToken,
    String content,
    bool privacy = false,
    int postType = 1,
    List<File> attachments = const [],
  });
  Future<DataState<List<PostEntity>>> GetPostByID({
    required int userID,
    required String accessToken,
    required int postID,
  });
}
