import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final int attachmentID;
  final String? filename;
  final int fileType;
  final String fileURL;

  Attachment({
    required this.attachmentID,
    this.filename,
    required this.fileType,
    required this.fileURL,
  });

  @override
  List<Object?> get props => [fileURL];

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      attachmentID: json['attachment_id'] ?? 0,
      filename: json['filename'] ?? "",
      fileType: json['file_type'],
      fileURL: json['file_url'],
    );
  }
}
