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
         metadata: await CommentService.createComment(req.body, req.user.userId),
       }).send(res);
     };
     // updateComment = async (req, res, next) => {
     //   new SuccessResponse({
     //     message: "Update file success",
     //     metadata: await CommentService.udpateComment(req.body, req.user.userId),
     //   }).send(res);
     // };
     // updateCommentAttachment = async (req, res, next) => {
     //   new SuccessResponse({
     //     message: "Update success",
     //     metadata: await CommentService.updateCommentAttachment(JSON.parse(req.body.new_attachments),  req.files),
     //   }).send(res);
     // };
     // deleteComment = async (req, res, next) => {
     //   new NoContentSuccess({
     //     message: "Delete success",
     //     metadata: await CommentService.deleteCommentById(req.body, req.user.userId),
     //   }).send(res);
     // };
   }
   
   module.exports = new CommentController();
   