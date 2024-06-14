import 'dart:io';

import 'package:vkuniversal/core/resources/data_state.dart';
import 'package:vkuniversal/core/usecase/usecase.dart';
import 'package:vkuniversal/features/auth/data/models/authorization.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';

class CreatePost implements UseCase<DataState<void>, CreatePostRequest> {
  final PostRepository _postRepository;

  CreatePost({required PostRepository postRepository})
      : _postRepository = postRepository;

  @override
  Future<DataState<void>> call({CreatePostRequest? data, Authorization? auth}) {
    return _postRepository.CreatePost(
      userID: auth!.userID,
      accessToken: auth.accessToken,
      content: data!.content ?? "",
      privacy: data.privacy,
      postType: data.postType,
      attachments: data.attachments,
    );
  }
}

class CreatePostRequest {
  final String? content;
  final bool privacy;
  final int postType;
  final List<File> attachments;

  CreatePostRequest({
    required this.content,
    required this.privacy,
    required this.postType,
    required this.attachments,
  });
}
