const {
  createPost,
  deletePostById,
  updatePost,
  updatePostByIdAndUserId,
  updateAttachmentFileUrl,
  getLatestPosts,
  getLatestPostsFollowed,
  getPostById,
  getLatestPostsByField,
  likePost,
  unlikePost,
  getPostsByUserId
} = require("../../dbs/post/pg.post");

const { BadRequestError, NotFoundError } = require("../../core/error.response");
const { uploadFileToFirebase, deleteFileFromFirebase, updateFileFromFirebase } = require("../../dbs/post/firebase.post");
const { createAttachment } = require("../../dbs/post/pg.attachment");
const { NoContentSuccess } = require("../../core/success.response");
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
          return createAttachment(newPost.post_id, `${attachment.fieldname}/${attachment.originalname}`, attachment.mimetype == ("video/mp4") ? 1 : 0, url);
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
  static async getPost(post_id) {

    const result = await getPostById(post_id);

    console.log("ssdad", result);
    if (!result) {
      throw new BadRequestError("Cannot get post");
    } 
    return result
  }

  static async getAllPost(page, user_id) {

    const result = await getLatestPosts(page, user_id);

    console.log("ssdad", result);
    if (!result) {
      throw new BadRequestError("Cannot get post");
    } 

    if ( result.length == 0 ) throw new NoContentSuccess("Out of posts to get")

    return result
  }
  
  static async getPostFollowed(page) {

    const result = await getLatestPostsFollowed(page);

    if (!result) {
      throw new BadRequestError("Cannot get post");
    }

    return result
  }

  static async getPostByUserId(_user_id, payload) {
    console.log("vo day roui na");
    const {user_id, page} = payload

    const result = await getPostsByUserId(page, _user_id, user_id);

    if (!result) {
      throw new BadRequestError("Cannot get post");
    }

    return result
  }


  static async getPostsByField(field, page) {

    const result = await getLatestPostsByField(field, page);

    if (!result) {
      throw new BadRequestError("Cannot get post");
    }
    
    if (result.length == 0) throw new NotFoundError("Out of posts to get")

    return result
  }
  static async createLikePost(post_id, user_id) {

    const result = await likePost(post_id, user_id);

    if (!result) {
      throw new BadRequestError("Cannot like post");
    }
  }
  static async unLikePost(post_id, user_id) {

    const result = await unlikePost(post_id, user_id);

    if (!result) {
      throw new BadRequestError("Cannot unlike post");
    }

  }

}

module.exports = PostService;