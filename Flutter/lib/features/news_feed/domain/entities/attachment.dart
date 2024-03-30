import 'package:vkuniversal/core/util/enums/attachment_type.dart';

class Attachment {
  final int id;
  final AttachmentType attachmentType;
  final String url;

  Attachment(
      {required this.id, required this.attachmentType, required this.url});
}
