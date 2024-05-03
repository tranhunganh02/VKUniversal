import 'package:intl/intl.dart';

String formatTimestamp(String timestamp) {
  final createdAt = DateTime.parse(timestamp);
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inDays > 0) {
    return DateFormat.yMMMd().format(createdAt);
  } else if (difference.inHours > 0) {
    return '${difference.inHours.toString()} hours ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes.toString()} minutes ago';
  } else {
    return 'Just now';
  }
}
