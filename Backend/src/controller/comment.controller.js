const {
     CREATED,
     SuccessResponse,
     NoContentSuccess,
   } = require("../core/success.response");
   const CommentService = require("../services/post/comment.service");
   
   class CommentController {
     createComment = async (req, res, next) => {
       new CREATED({
         message: "Created success",
         metadata: await CommentService.createComment(req.body, req.user.userId, req.files),
       }).send(res);
     };
     updateComment = async (req, res, next) => {
       new SuccessResponse({
         message: "Update comment success",
         metadata: await CommentService.udpateComment(req.body, req.user.userId),
       }).send(res);
     };
     getCommentsById = async (req, res, next) => {
       new SuccessResponse({
         message: "Update success",
         metadata: await CommentService.getCommentsById(req.body),
       }).send(res);
     };
     deleteComment = async (req, res, next) => {
       new NoContentSuccess({
         message: "Delete success",
         metadata: await CommentService.deleteComment(req.body.comment_id, req.user.userId),
       }).send(res);
     };
   }
   
   module.exports = new CommentController();
   