const {
  createPost,
  getPostById,
  deletePostById,
  updatePost,
  updatePostByIdAndUserId,
} = require("../../dbs/post/pg.post");

const { BadRequestError } = require("../../core/error.response");
const { uploadFileToFirebase, deleteFileFromFirebase } = require("../../dbs/post/firebase.post");
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

    // const attachment = payload.attachment;

    // const uploadedFileUrls = await Promise.all(
    //   attachment.map(async (file) => {
    //     const buffer = file.buffer;
    //     return await PostService.uploadImagesToFirebase(file);
    //   })
    // );

    delete payload.post_id;
    delete payload.attachment;

    const result = await updatePostByIdAndUserId(post_id, userId, payload);

    console.log(result);

    return result;
  }

  static async updatePrivacy(payload, user) {}

  static async updateContent(payload, user) {}

  static async updatePostType(payload, user) {
    // Xử lý cập nhật loại bài đăng
  }

  static async updateAttachemnt(payload, user) {}

  static async updateContentPrivacyTypeAttachment(payload, user) {
    // Xử lý cập nhật toàn bộ dữ liệu
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

  static async uploadImagesToFirebase(payload, user, files) {
    console.log("payload", payload, user, "files", files);

    console.log("attachment", files);
    const attachmentUrls = await Promise.all(
      files.map(async (file) => {
        const buffer = file.buffer;

        return await uploadImageToFirebase(buffer, file);
      })
    );

    return attachmentUrls;
  }
}

module.exports = PostService;
