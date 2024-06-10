
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/constants/constants.dart';
import 'package:vkuniversal/core/constants/share_pref.dart';
import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/data/model/page_request.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_posts.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    initializeDependencies();
  });
  test("Get posts", () async {
    // PostApiService postApiService = sl<PostApiService>();
    GetPosts getPosts = sl<GetPosts>();

    final userID = 13;
    final accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzLCJlbWFpbCI6Imx2bWluaEB2a3UudWRuLnZuIiwicm9sZSI6MiwiaWF0IjoxNzE3ODY2OTQzLCJleHAiOjE3MTc4ODMxNDN9.-gQTlKxzpfYEgCEtt6bDE0s_sIYEfsPiUTjRsqfPPdg';
    final page = PageRequest(page: 1);

    SharedPreferences _pref = await SharedPreferences.getInstance();
    Authorization authorization = SetUpAuthData(_pref);

    // final result = await postApiService.getPosts(userID, accessToken, page);
    final result = await getPosts(auth: authorization, data: page);

    logger.d(result);
    expect(result is DataSuccess, true);
  });
}
