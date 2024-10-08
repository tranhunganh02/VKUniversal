const {
  createPost,
  getPostById,
  deletePostById,
  updatePost,
  updatePostByIdAndUserId,
  updateAttachmentFileUrl
} = require("../../dbs/post/pg.post");

const { BadRequestError } = require("../../core/error.response");
const { uploadFileToFirebase, deleteFileFromFirebase, updateFileFromFirebase } = require("../../dbs/post/firebase.post");
const { createAttachment } = require("../../dbs/post/pg.attachment");
class PostService {
  // create post here
  // file_type:0 "image/jpg", :1"video"
  // post_type:0-> normal, :1-> thong bao do that lac
  // attachment ( file_url ) push to firebase
  static async createPost(payload, user_id, attachments) {

    const { content, privacy, post_type } = payload;
    //check missing value
    if (!content || !user_id || post_type == null)
      throw new BadRequestError("Some fields required are missing");

    const newPost = await createPost(content, user_id, privacy, post_type);

    if (attachments) {
      const attachmentURLs = await Promise.all(
        attachments.map(async (attachment) => {
          const url = await uploadFileToFirebase(attachment.buffer, attachment);
          console.log("url ", url);
          return createAttachment(newPost.post_id, attachment.file_name, attachment.file_type, url);
        })
      );
      if (!attachmentURLs) {
        throw BadRequestError("Cannot push image");
      }
      const result = {
        newPost,
        attachment: attachmentURLs,
      };
      return result
    }

    return newPost;
  }

  static async udpatePost(payload, userId) {
    const post_id = payload.post_id;

    delete payload.post_id;
    delete payload.attachment;

    const result = await updatePostByIdAndUserId(post_id, userId, payload);

    console.log(result);

    return result;
  }


  static async updatePostAttachment(payload, files) {
    const attachmentURLs = await Promise.all(payload.map(async (attachment, index) => {
      console.log("attachment", attachment.file_url);
      // await deleteFileFromFirebase( attachment.file_url);
      const newUrl = await updateFileFromFirebase(attachment.file_url, files[index].buffer, files[index]);
      return await updateAttachmentFileUrl(attachment.attachment_id, newUrl)
      
    }));
    return attachmentURLs
  }

  static async deletePostById(payload, user_id) {

    

    const { post_id, file_urls } = payload;
    const result = await deletePostById(post_id, user_id);

    if (!result) {
      throw new BadRequestError("Cannot delete post");
    }
     // 3. Delet file from Firebase Storage
   try {
    await Promise.all(file_urls.map(async (file) => {
      await deleteFileFromFirebase(file);
    }));

   } catch (error) {
    throw error
   }
  }

}

module.exports = PostService;
