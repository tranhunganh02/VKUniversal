import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) {
  final createdAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final now = DateTime.now();
  final difference = now.difference(createdAt);
  print("\n object vo roi day \n");
  if (difference.inDays > 0) {
    print("object ${ DateFormat.yMMMd().format(createdAt)}");
    return DateFormat.yMMMd().format(createdAt);
  } else if (difference.inHours > 0) {
     print("${difference.inHours} hours ago");
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
         print("${difference.inMinutes} minutes ago");
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}