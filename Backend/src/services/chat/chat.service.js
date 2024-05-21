const { NotFoundError, BadRequestError } = require("../../core/error.response");
const { getListChatUser, createChatRoom } = require("../../dbs/chat/firebase.chat");
const { checkMutualFollow } = require("../../dbs/chat/pg.chat");

class ChatService {
     static async getListChatByUserId(user_id, page) {

          const result = await getListChatUser(user_id, page);

          if (!result) throw new BadRequestError("Cannot get data");

          if(result.mess) throw new NotFoundError(result.mess)

          return result;
     }
     static async createChatRoomByUserFollow(follower_id, followed_id) {

          const isMutualFollow = await checkMutualFollow(follower_id, followed_id);

          // Nếu cả hai người đều follow lẫn nhau, tạo phòng chat
          if (isMutualFollow) {
              const result = await createChatRoom(follower_id, followed_id);
              
              if(!result) throw new BadRequestError('Canot create chat room')

              return result; // Trả về kết quả từ hàm tạo phòng chat
          } else {
              throw new BadRequestError('Both users are not following each other.');
          }
     }
}

module.exports = ChatService;
