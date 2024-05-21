const {
  CREATED,
  SuccessResponse,
  NoContentSuccess,
} = require("../core/success.response");
const ChatService = require("../services/chat/chat.service");

class ChatController {
  getChat = async (req, res, next) => {
    new SuccessResponse({
      message: "get data success",
      metadata: await ChatService.getListChatByUserId(req.user.userId, req.body.page),
    }).send(res);
  };
  createRoomChat = async (req, res, next) => {
    new CREATED({
      message: "Created success",
      metadata: await ChatService.createChatRoomByUserFollow(
          req.user.userId,
          req.body.user_id,
      ),
    }).send(res);
  };

}

module.exports = new ChatController();
