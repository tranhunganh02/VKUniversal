const {
  CREATED,
  SuccessResponse,
  NoContentSuccess,
} = require("../core/success.response");
const PostService = require("../services/post/post.service");

class PostController {
  createPost = async (req, res, next) => {
    new CREATED({
      message: "Created success",
      metadata: await PostService.createPost(req.body, req.user.userId, req.files),
    }).send(res);
  };
  updatePost = async (req, res, next) => {
    new SuccessResponse({
      message: "Update file success",
      metadata: await PostService.udpatePost(req.body, req.user.userId),
    }).send(res);
  };
  updatePostAttachment = async (req, res, next) => {
    new SuccessResponse({
      message: "Update success",
      metadata: await PostService.updatePostAttachment(JSON.parse(req.body.new_attachments),  req.files),
    }).send(res);
  };
  deletePost = async (req, res, next) => {
    new NoContentSuccess({
      message: "Delete success",
      metadata: await PostService.deletePostById(req.body, req.user.userId),
    }).send(res);
  };
}

module.exports = new PostController();
