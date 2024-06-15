import 'dart:io';

import 'package:equatable/equatable.dart';

class MessageEnitites extends Equatable {
  final String idMessage;
  final int userId;
  final String message;
  final File? file;

  MessageEnitites(
      {required this.idMessage,
      required this.userId,
      required this.message,
      required this.file});

  @override
  // TODO: implement props
  List<Object?> get props => [userId, message];
}
