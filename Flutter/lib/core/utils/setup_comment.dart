import 'package:vkuniversal/features/newsfeed/data/model/cmt_tree_model.dart';
import 'package:vkuniversal/features/newsfeed/data/model/comment.dart';

List<CmtTreeModel> setUpCommentTree(List<CommentModel> comments) {
  if (comments.length == 0) return [];
  final List<CmtTreeModel> tree = [];
  List<CommentModel> processedComments = [];

  for (var comment in comments) {
    if (comment.prID == null) {
      tree.add(CmtTreeModel(comment, []));
      processedComments.add(comment);
    }
  }
  comments.removeWhere((comment) => processedComments.contains(comment));

  for (var comment in tree) {
    for (var commentElse in comments) {
      if (commentElse.prID == comment.node.commentID) {
        comment.children.add(CmtTreeModel(commentElse, []));
        processedComments.add(commentElse);
      }
    }
  }
  comments.removeWhere((comment) => processedComments.contains(comment));

  return tree;
  // return [
  //   CmtTreeModel(
  //     CommentModel(
  //         commentID: '', postID: 0, userID: 0, prID: '', content: 'Hello'),
  //     [
  //       CmtTreeModel(
  //           CommentModel(
  //             commentID: '',
  //             postID: 0,
  //             userID: 0,
  //             prID: '',
  //             content: 'you',
  //           ),
  //           []),
  //       CmtTreeModel(
  //           CommentModel(
  //             commentID: '',
  //             postID: 0,
  //             userID: 0,
  //             prID: '',
  //             content: 'bitch',
  //           ),
  //           [])
  //     ],
  //   ),
  //   CmtTreeModel(
  //       CommentModel(
  //           commentID: '', postID: 0, userID: 0, prID: '', content: 'Hi'),
  //       [])
  // ];
}
