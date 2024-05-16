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
    new SuccessResponse({
      message: "Get data success",
      metadata: await UserService.getProfile(req.body.user_id, req.body.role),
    }).send(res);
  };
  checkStudentExist = async (req, res, next) => {
    new SuccessResponse({
      message: "Get data success",
      metadata: await UserService.checkStudentExist(req.body.user_id),
    }).send(res);
  };
}
module.exports = new UserController();
