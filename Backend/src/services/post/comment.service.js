const { BadRequestError } = require("../../core/error.response");
const { createCommentToFb } = require("../../dbs/post/firebase.comment");

class CommentService {

  static async createComment(payload, user_id) {
    const { post_id, content, image, level, path } = payload;
    //check missing value
    if (!content || !user_id || !post_id)
      throw new BadRequestError("Some fields required are missing");

    const newComment = await createCommentToFb(post_id, user_id, content, image);
    return newComment
  }

}
module.exports = CommentService;
