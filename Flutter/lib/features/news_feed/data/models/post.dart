import 'package:vkuniversal/features/news_feed/domain/entities/post.dart';

class PostModel extends PostEntity {
  PostModel(super.id, super.authorID, super.content, super.privacy,
      super.postType, super.updateAt, super.publicAt);
}
