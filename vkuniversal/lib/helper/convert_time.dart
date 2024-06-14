import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) {
  final createdAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inDays > 0) {
    return DateFormat.yMMMd().format(createdAt);
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}
