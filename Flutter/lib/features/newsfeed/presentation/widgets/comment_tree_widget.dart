// import 'package:comment_tree/comment_tree.dart';
// import 'package:comment_tree/widgets/tree_theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:vkuniversal/features/newsfeed/data/model/comment.dart';

// class CommentTreeWidget extends StatelessWidget {
//   final TreeThemeData treeThemeData = TreeThemeData(
//     lineColor: Colors.green[500]!,
//     lineWidth: 3,
//   );
//   CommentTreeWidget(
//     CommentModel rootComment,
//     List<CommentModel> childComments, {
//     super.key,
//     required treeThemeData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CommentTreeWidget<CommentModel, CommentModel>(
//       CommentModel(
//         commentID: '',
//         postID: 20,
//         userID: 32,
//         prID: '',
//         content: '',
//       ),
//       [
//         CommentModel(
//           commentID: '',
//           postID: 20,
//           userID: 32,
//           prID: '',
//           content: '',
//         ),
//         CommentModel(
//           commentID: '',
//           postID: 20,
//           userID: 32,
//           prID: '',
//           content: '',
//         )
//       ],
//       treeThemeData: treeThemeData,
//     );
//   }
// }
