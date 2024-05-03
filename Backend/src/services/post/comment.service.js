const { BadRequestError, ForbiddenError, NotFoundError } = require("../../core/error.response");
const { createCommentToFb, updateCommentToFb, deleteCommentToFb,checkCommentExists, getCommentsByCommentId } = require("../../dbs/post/firebase.comment");

const { uploadFileToFirebase, deleteFileFromFirebase, updateFileFromFirebase } = require("../../dbs/post/firebase.post");

class CommentService {

  static async createComment(payload, user_id, attachments) {
    // 1. check field comment
    // 2. if have path and level -> check comment parent
    // 3. if have attachments -> push attachments
    // 4. return data
    const { post_id, content, path, level } = payload;
    //1.
    if (!content || !user_id || !post_id)
      throw new BadRequestError("Some fields required are missing");
    //2.
    if( path && level){
      const checkCommentParent = await checkCommentExists(path)
      if(!checkCommentParent) throw new NotFoundError("Comment parent not found ")
    }  
    //3.
    if (attachments) {
      const attachmentURLs = await Promise.all(
        attachments.map(async (attachment) => {
          const url = await uploadFileToFirebase(attachment.buffer, attachment);
          console.log("url in create image comment", url);
          return url
        }),
      );
      if (!attachmentURLs) {
        throw BadRequestError("Cannot push image");
      }
      console.log("attachmentURLs", attachmentURLs);
      const newComment = await createCommentToFb(Number(post_id), user_id, content,attachmentURLs, path, level);

      if(!newComment) throw new BadRequestError("Can not create comment")
      //4
      return newComment
    }

    const newComment = await createCommentToFb(Number(post_id), user_id, content, path, level);

    if(!newComment) throw new BadRequestError("Can not create comment")
      //4.
    return newComment
  }

  static async udpateComment(payload, user_id) {
    const {comment_id, content,image, path, level } = payload;
    //check missing value
    if (!content || !user_id || !comment_id)
      throw new BadRequestError("Some fields required are missing");
    const newComment = await updateCommentToFb(comment_id, content,image, path, level);

    if(!newComment) throw new BadRequestError("Can not create comment")
    return newComment
  }

  static async deleteComment( comment_id, user_id) {
    if (!user_id || !comment_id)
      throw new BadRequestError("Some fields required are missing");

    const delData = await deleteCommentToFb(comment_id, user_id)

    if(!delData) throw new ForbiddenError("You are not authorized to delete this comment") 

  }
  static async getCommentsById(payload) {
    const { comment_id, post_id, path, level } = payload;
    // if (!comment_id)
    //   throw new BadRequestError("Some fields required are missing");

    const comments = await getCommentsByCommentId(comment_id, Number(post_id), path, level)

    if(!comments) throw new NotFoundError("Comment parent not found ") 

    return comments
  }

}
module.exports = CommentService;
