import 'package:vkuniversal/features/news_feed/data/models/attachment.dart';
import 'package:vkuniversal/features/news_feed/data/models/post.dart';

class AttachmentPost extends PostModel {
  List<Attachment>? attachments;

  AttachmentPost(super.id, super.authorID, super.content, super.privacy,
      super.postType, super.updateAt, super.publicAt);
}
