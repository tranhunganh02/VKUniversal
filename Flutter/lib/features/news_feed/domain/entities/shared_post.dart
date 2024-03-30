import 'package:vkuniversal/features/news_feed/domain/entities/sub_content.dart';

class SharedPost extends SubContent {
  String postUrl;

  SharedPost(this.postUrl, {required super.id, required super.subContentType});
}
