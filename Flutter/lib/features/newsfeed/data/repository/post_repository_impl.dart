import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/refresh_token.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/usecases/logout.dart';
import 'package:vkuniversal/features/auth/domain/usecases/refresh_token.dart';
import 'package:vkuniversal/features/newsfeed/data/datasourse/remote/post_api_service.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService _postApiService;

  PostRepositoryImpl({required PostApiService postApiService})
      : _postApiService = postApiService;
  @override
  Future<DataState<List<PostModel>>> getPosts({
    required int userID,
    required String accessToken,
    required PageRequest page,
  }) async {
    try {
      final response =
          await _postApiService.getPosts(userID, accessToken, page);
      logger.d("At Get Posts: ${userID}: ${accessToken}");

      if (response.response.statusCode == HttpStatus.ok) {
        logger.d("Posts: Get successfully");
        return DataSuccess(response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RefreshToken(authRepository: sl());
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        return await getPosts(
            userID: authorization.userID,
            accessToken: authorization.accessToken,
            page: page);
      } else if (response.response.statusCode == 404) {
        logger.d("Loi 404");
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      } else {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } catch (e) {
      RequestOptions options = RequestOptions();
      logger.d("At PostAPIService: $e");
      return DataFailed(DioException(requestOptions: options));
    }
  }

  @override
  Future<DataState<void>> CreatePost({
    required int userID,
    required String accessToken,
    String content = "",
    bool privacy = false,
    int postType = 1,
    List<File> attachments = const [],
  }) async {
    try {
      // final _pref = await SharedPreferences.getInstance();
      // Authorization authorization = SetUpAuthData(_pref);
      List<MultipartFile> imageFiles = [];
      for (var path in attachments) {
        logger.d("Path: $path");
        for (var file in attachments) {
          try {
            imageFiles.add(await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last));
          } catch (e) {
            print('Error with file path ${file.path}: $e');
            continue;
          }
        }
      }
      final response = await _postApiService.CreatePost(
        userID,
        accessToken,
        content,
        privacy,
        postType,
        imageFiles,
      );

      if (response.response.statusCode == HttpStatus.created) {
        return DataSuccess(response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RefreshTokenCommon();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        return await CreatePost(
          userID: authorization.userID,
          accessToken: authorization.accessToken,
          content: content,
          privacy: privacy,
          postType: postType,
          attachments: attachments,
        );
      } else {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options, message: "1"));
      }
    } on DioException catch (e) {
      logger.e(e);

      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> LikeThePost(
      {required int userID,
      required String accessToken,
      required int postID}) async {
    try {
      final postRequest = PostRequest(postID: postID);
      final response =
          await _postApiService.LikeThePost(userID, accessToken, postRequest);

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RefreshTokenCommon();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        return await LikeThePost(
          userID: authorization.userID,
          accessToken: authorization.accessToken,
          postID: postID,
        );
      } else {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(
            requestOptions: options, message: "Like ko thanh cong!"));
      }
    } on DioException catch (e) {
      RequestOptions options = RequestOptions();
      return DataFailed(DioException(requestOptions: options, message: "$e"));
    }
  }

  @override
  Future<DataState<void>> UnlikeThePost({
    required int userID,
    required String accessToken,
    required int postID,
  }) async {
    try {
      final postRequest = PostRequest(postID: postID);
      final response =
          await _postApiService.UnLikeThePost(userID, accessToken, postRequest);
      if (response.response.statusCode == HttpStatus.ok) {
        logger.d("UnLike thanh cong");
        return DataSuccess(response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RefreshTokenCommon();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        return await UnlikeThePost(
          userID: authorization.userID,
          accessToken: authorization.accessToken,
          postID: postID,
        );
      } else {
        Logout(authRepository: sl());
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(
            requestOptions: options, message: "UnLike ko thanh cong!"));
      }
    } on DioException catch (e) {
      RequestOptions options = RequestOptions();
      return DataFailed(DioException(requestOptions: options, message: "$e"));
    }
  }
}
