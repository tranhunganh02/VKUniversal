const { BadRequestError, ForbiddenError, NotFoundError } = require("../../core/error.response");
const { createCommentToFb, updateCommentToFb, deleteCommentToFb,checkCommentExists, getCommentsByCommentId } = require("../../dbs/post/firebase.comment");

const { uploadFileToFirebase, deleteFileFromFirebase, updateFileFromFirebase } = require("../../dbs/post/firebase.post");

class CommentService {

  static async createComment(payload, user_id, attachments) {
    // 1. check field comment
    // 2. if have path and level -> check comment parent
    // 3. if have attachments -> push attachments
    // 4. return data
    const { post_id, content, pr_id } = payload;
    console.log("pr_id", pr_id);
    //1.
    if (!content || !user_id || !post_id)
      throw new BadRequestError("Some fields required are missing");
    //2.
    if( pr_id){
      const checkCommentParent = await checkCommentExists(pr_id)
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
      const newComment = await createCommentToFb(Number(post_id), user_id, content,attachmentURLs,pr_id);

      if(!newComment) throw new BadRequestError("Can not create comment")
      //4
      return newComment
    }

    const newComment = await createCommentToFb(Number(post_id), user_id, content, null, pr_id);

    if(!newComment) throw new BadRequestError("Can not create comment")
      //4.
    return newComment
  }

  static async udpateComment(payload, user_id) {
    const {comment_id, content,image } = payload;

    console.log(payload);
    //check missing value
    if (!content || !comment_id)
      throw new BadRequestError("Some fields required are missing");
    const newComment = await updateCommentToFb(comment_id, content,image);

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
    const { pr_id, post_id} = payload;
    // if (!comment_id)
    //   throw new BadRequestError("Some fields required are missing");

    const comments = await getCommentsByCommentId(pr_id, Number(post_id),)

    if(!comments) throw new NotFoundError("Comment parent not found ") 

    return comments
  }

}
module.exports = CommentService;
