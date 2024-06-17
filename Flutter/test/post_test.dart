import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/datasourse/remote/comment_api_service.dart';
import 'package:vkuniversal/features/newsfeed/data/datasourse/remote/post_api_service.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_posts.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    initializeDependencies();
  });
  test("Get posts", () async {
    // PostApiService postApiService = sl<PostApiService>();
    GetPosts getPosts = sl<GetPosts>();

    final userID = 28;
    final accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjI4LCJlbWFpbCI6Imh0c2FuZzIudGdAdmt1LnVkbi52biIsInJvbGUiOjEsImlhdCI6MTcxODI5MTk3NSwiZXhwIjoxNzE4MzA4MTc1fQ.QOApx0gH-o7OicXiA3d6xEwA-lGXKnzup6eOYTGXUqs';
    final page = PageRequest(page: 1);

    SharedPreferences _pref = await SharedPreferences.getInstance();
    Authorization authorization = SetUpAuthData(_pref);
    authorization.userID = userID;
    authorization.accessToken = accessToken;

    // final result = await postApiService.getPosts(userID, accessToken, page);
    final result = await getPosts(auth: authorization, data: page);

    logger.d(result);
    for (var item in result.data!) {
      logger.d(item);
    }
    expect(result is DataSuccess, true);
  });
  test("Create Post", () async {
    final postApiService = sl<PostApiService>();

    final userID = 28;
    final accessToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjI4LCJlbWFpbCI6Imh0c2FuZzIudGdAdmt1LnVkbi52biIsInJvbGUiOjEsImlhdCI6MTcxODI4OTY0OCwiZXhwIjoxNzE4MzA1ODQ4fQ.09IrPhBxC2MDDZSSVcl4I44OsWf2F1dP3g2O0BJJSeA";

    final content = "Test";
    final privacy = false;
    final postType = 1;
    final attachments = <MultipartFile>[];

    final response = await postApiService.CreatePost(
        userID, accessToken, content, privacy, postType, attachments);

    logger.d(response);

    expect(response.response.statusCode, 201);
  });
  test("Create post with image via repository", () async {
    final PostRepository postRepository = sl<PostRepository>();

    final response = await postRepository.CreatePost(
      userID: 30,
      accessToken:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMwLCJlbWFpbCI6Imh1eXRuLjIxaXRAdmt1LnVkbi52biIsInJvbGUiOjEsImlhdCI6MTcxODI3MDUyMywiZXhwIjoxNzE4Mjg2NzIzfQ.TlvykQVN7pDZJRYMr7jb9JNh4f6ysujvqF92jlfsG-g",
      content: "Test",
      privacy: false,
      postType: 1,
      attachments: <File>[
        File("/storage/emulated/0/Pictures/ra.png"),
      ],
    );

    // logger.d(response.error!.message);
    expect(response is DataSuccess, true);
  });
  test("Get Comments", () async {
    CommentApiService commentApiService = CommentApiService(sl());

    final response = await commentApiService.getComments(
        28,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjI4LCJlbWFpbCI6Imh0c2FuZzIudGdAdmt1LnVkbi52biIsInJvbGUiOjEsImlhdCI6MTcxODUyMDAxNywiZXhwIjoxNzE4NTM2MjE3fQ.GBc9om7vH8PffpXAIMXbUdAH38HgvsDO9R69GzNs3Cg",
        PostRequest(postID: 105));

    logger.d(response.data);
    expect(response.data.isNotEmpty, true);
  });
}
