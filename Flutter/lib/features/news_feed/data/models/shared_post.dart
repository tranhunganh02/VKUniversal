import 'package:vkuniversal/features/news_feed/data/models/post.dart';

class SharedPost extends PostModel {
  final String? sharedPostID;

  SharedPost(super.id, super.authorID, super.content, super.privacy,
      super.postType, super.updateAt, super.publicAt,
      {required this.sharedPostID});
}
