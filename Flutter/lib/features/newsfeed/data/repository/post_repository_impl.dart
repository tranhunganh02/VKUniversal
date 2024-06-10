import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/auth/domain/usecases/refresh_token.dart';
import 'package:vkuniversal/features/newsfeed/data/datasourse/remote/post_api_service.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/data/model/post_model.dart';
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
      return DataFailed(DioException(requestOptions: options));
    }
  }
}
