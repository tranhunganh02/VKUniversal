import 'package:vkuniversal/features/news_feed/domain/entities/attachment.dart';
import 'package:vkuniversal/features/news_feed/domain/entities/sub_content.dart';

class Media extends SubContent {
  List<Attachment> attachments;

  Media(this.attachments, {required super.id, required super.subContentType});
}
