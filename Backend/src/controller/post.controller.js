const {
  CREATED,
  SuccessResponse,
  NoContentSuccess,
} = require("../core/success.response");
const PostService = require("../services/post/post.service");

class PostController {
  getPost = async (req, res, next) => {
    new SuccessResponse({
      message: "get data success",
      metadata: await PostService.getPost(req.query.post_id),
    }).send(res);
  };
  getPostsByField = async (req, res, next) => {
    const { field, page } = req.query
    new SuccessResponse({
      message: "get data success",
      metadata: await PostService.getPostsByField(field, page),
    }).send(res);
  };
  getAllPost = async (req, res, next) => {
    new SuccessResponse({
      message: "get data success",
      metadata: await PostService.getAllPost(req.body.page),
    }).send(res);
  };
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
  getPostFollowed = async (req, res, next) => {
    new SuccessResponse({
      message: "get data success",
      metadata: await PostService.getPostFollowed(req.body.page),
    }).send(res);
  };
}

module.exports = new PostController();
