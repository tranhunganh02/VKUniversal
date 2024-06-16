import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/refresh_token.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/datasourse/remote/comment_api_service.dart';
import 'package:vkuniversal/features/newsfeed/data/model/comment_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/entities/comment.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentApiService _commentApiService;

  CommentRepositoryImpl({required CommentApiService commentApiService})
      : _commentApiService = commentApiService;
  @override
  Future<DataState<List<CommentEntity>>> getComments(
      {required int userID,
      required String accessToken,
      required int postID}) async {
    try {
      final _response = await _commentApiService.getComments(
        userID,
        accessToken,
        PostRequest(postID: postID),
      );
      if (_response.response.statusCode == HttpStatus.ok) {
        logger.d("Comments: Get successfully");
        return DataSuccess(_response.data);
      } else if (_response.response.statusCode == HttpStatus.unauthorized) {
        RefreshTokenCommon();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        return await getComments(
          userID: authorization.userID,
          accessToken: authorization.accessToken,
          postID: postID,
        );
      } else {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      RequestOptions options = RequestOptions();
      logger.d("At PostAPIService: $e");
      return DataFailed(DioException(requestOptions: options));
    }
  }

  @override
  Future<DataState<void>> createComment(
      {required int userID,
      required String accessToken,
      required int postID,
      required String content}) async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      Authorization authorization = SetUpAuthData(_pref);
      final response = await _commentApiService.createComment(
        userID,
        accessToken,
        CommentRequest(postID: postID, content: content),
      );
      if (response.response.statusCode == HttpStatus.ok) {
        logger.d("Comments: Create successfully");
        return DataSuccess(response.data);
      } else if (response.response.statusCode == HttpStatus.unauthorized) {
        RefreshTokenCommon();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        Authorization authorization = SetUpAuthData(_pref);
        return await createComment(
            userID: authorization.userID,
            accessToken: authorization.accessToken,
            postID: postID,
            content: content);
      } else {
        RequestOptions options = RequestOptions();
        return DataFailed(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      RequestOptions options = RequestOptions();
      return DataFailed(
          DioException(requestOptions: options, message: e.toString()));
    }
  }
}
