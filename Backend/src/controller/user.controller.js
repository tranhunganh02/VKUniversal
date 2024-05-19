const {
  CREATED,
  SuccessResponse,
  NoContentSuccess,
} = require("../core/success.response");
const UserService = require("../services/user/user.service");

class UserController {
  updateUser = async (req, res, next) => {
    new SuccessResponse({
      message: "Update user success",
      metadata: await UserService.updateUser(req.user.userId, req.user.role, req.body),
    }).send(res);
  };
  updateUserProfile = async (req, res, next) => {
    new SuccessResponse({
      message: "Update user success",
      metadata: await UserService.updateProfile(req.user.userId, req.body),
    }).send(res);
  };
  getUserProfile = async (req, res, next) => {
    const { user_id, role } = req.query;
    new SuccessResponse({
      message: "Get data success",
      metadata: await UserService.getProfile(Number(user_id), Number(role)),
    }).send(res);
  };
  checkStudentExist = async (req, res, next) => {
    new SuccessResponse({
      message: "Get data success",
      metadata: await UserService.checkStudentExist(req.body.user_id),
    }).send(res);
  };
  createFollow = async (req, res, next) => {
    new CREATED({
      message: "Create success",
      metadata: await UserService.createFollow(req.user.userId, req.body.followed_id),
    }).send(res);
  };
  unFollow = async (req, res, next) => {
    new NoContentSuccess({
      message: "Delete success",
      metadata: await UserService.deleteFollow(req.user.userId, req.body.followed_id),
    }).send(res);
  };
}
module.exports = new UserController();
