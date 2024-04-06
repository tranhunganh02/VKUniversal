const { CREATED, SuccessResponse} = require("../core/success.response");
const PostService = require("../services/post/post.service");

class PostController {
  handlerRefreshToken = async (req, res, next) => {
     new SuccessResponse({
          message: "GEt token success!!",
          // metadata:  await PostService.handlerRefreshToken(req.body.refreshToken)
     }).send(res)
  }
  createPost = async (req, res, next) => {
     console.log(req.body);
    new SuccessResponse({
         message: "Login sucess",
     //     metadata: await PostService.login(req.body)
    }).send(res)
 };
  updatePost = async (req, res, next) => {

     new CREATED({
          message: "Registerted sucess",
          // metadata: await PostService.signUp(req.body)
     }).send(res)
  };
  logout = async (req, res, next) => {

     new SuccessResponse({
          message: "Logout sucess",
          // metadata: await PostService.logout(req.keyStore)
     }).send(res)
  };
}

module.exports = new AccessController();
