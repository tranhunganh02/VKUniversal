const {
  CREATED,
  SuccessResponse,
  NoContentSuccess,
} = require("../core/success.response");
const PostService = require("../services/post/post.service");

class PostController {
  imageTest = async (req, res, next) => {
    new SuccessResponse({
      message: "Created success",
      metadata: await PostService.uploadImagesToFirebase(req.body, req.user, req.files),
    }).send(res);
  };
  createPost = async (req, res, next) => {
    new SuccessResponse({
      message: "Created success",
      metadata: await PostService.createPost(req.body, req.user.userId, req.files),
    }).send(res);
  };
  updatePost = async (req, res, next) => {
    console.log("body ", req.body);
    new SuccessResponse({
      message: "Update success",
      metadata: await PostService.udpatePost(req.body, req.user.userId),
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
