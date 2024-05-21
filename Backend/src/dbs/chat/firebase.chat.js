const firebase = require("firebase-admin");
const { getUserAvatar } = require("../user/pg.user");
const db = firebase.firestore();

const PAGE_SIZE = 7; // Kích thước trang

// // Lấy thời gian hiện tại dưới dạng dấu thời gian Unix (mili giây)



const getListChatUser = async (user_id, page = 1) => {
    let queryRef = db.collection("chatroom")
                     .where("users", "array-contains", user_id)
                     .orderBy('create_at', "desc")
          

    if (page > 1) {
      const startAfterDoc = await getLastDocumentOnPage(user_id, page - 1);
      if (!startAfterDoc) {
        return {mess: "List chat is maximum"};
      }
      queryRef = queryRef.startAfter(startAfterDoc);
    }

    const querySnapshot = await queryRef.limit(PAGE_SIZE).get();

    if (querySnapshot.empty) {
     // Nếu không có dữ liệu trong querySnapshot, trả về thông báo
     return null;
   }

    const data = [];
    for (const doc of querySnapshot.docs) {
     const chatData = doc.data();
     chatData.document_id = doc.id;
     
     const userNumbers = chatData.users.filter(number => number !== user_id);

     console.log("user kasc laf", userNumbers[0]);
     if (userNumbers.length > 0) {
         const avatar = await getUserAvatar(userNumbers[0]);
         chatData.avatar = avatar;
     }

     data.push(chatData);
   }

    console.log("chatData", data);

    return data;

}

const getLastDocumentOnPage = async (user_id, page) => {

    const querySnapshot = await db.collection("chatroom")
                                  .where("users", "array-contains", user_id)
                                  .orderBy("create_at", "desc")
                                  .limit(page * PAGE_SIZE)
                                  .get();
    if (querySnapshot.empty || querySnapshot.size < (page * PAGE_SIZE)) {
      return null; // Không đủ dữ liệu để lấy trang này
    }
    // Trả về bản ghi cuối cùng của trang trước đó
    return querySnapshot.docs[querySnapshot.size - 1];
 
}

const createChatRoom = async (user1, user2) => {

     try {
          const now = new Date();
          const timestamp = now.getTime();
      
          const chatRoomRef = await firebase.firestore().collection('chatroom').add({
            create_at: timestamp,
            users: [user1, user2],
            lastmessage: null,
          });
          // Lấy thông tin của phòng chat vừa tạo và trả về cùng với Document ID
          const chatRoomSnapshot = await chatRoomRef.get();
          
          return { id: chatRoomRef.id, ...chatRoomSnapshot.data() }; 
        } catch (error) {
         return false
        }
 }
 
module.exports = {
  getListChatUser,
  createChatRoom
};
