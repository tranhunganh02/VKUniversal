import 'package:vkuniversal/core/util/enums/post_type.dart';
import 'package:vkuniversal/core/util/enums/privacy.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int id;
  final int authorID;
  final String content;
  final Privacy privacy;
  final PostType postType;
  final DateTime publicAt;
  DateTime? updateAt;

  PostEntity(this.id, this.authorID, this.content, this.privacy, this.postType,
      this.updateAt, this.publicAt);

  @override
  List<Object?> get props {
    return [id, authorID, content, privacy, postType, updateAt, publicAt];
  }
}
