const firebase = require("firebase-admin");
const db = firebase.firestore();
const {getUserAvatarAndNameByUserId} = require('../user/pg.user')
const createCommentToFb = async (
  postId,
  userId,
  content,
  image = null,
  pr_id = null
) => {
  const newComment = {
    post_id: postId,
    user_id: userId,
    content: content,
    pr_id: pr_id,
    image: image,
    created_at: new Date(), // Get server timestamp
    updated_at: null, // Get server timestamp
  };

  const commentRef = db.collection(`comments`).doc();
  await commentRef.set(newComment);
  const commentId = commentRef.id; // Get the comment_id
  const commentData = (await commentRef.get()).data();

  //convert time
  const timestamp = new firebase.firestore.Timestamp(
    commentData.created_at._seconds,
    commentData.created_at._nanoseconds
  );
  commentData.created_at = timestamp.toDate();
  return { comment_id: commentId, ...commentData };
};
const checkCommentExists = async (comment_id) => {
  const docRef = db.collection("comments").doc(comment_id);
  const docSnapshot = await docRef.get();
  return docSnapshot.exists;
};

const updateCommentToFb = async (
  comment_id,
  content,
  image = null,
) => {
  const newComment = {
    content: content,
    updated_at: new Date(), // Get server timestamp
  };

  if (image !== null) {
    newComment.image = image;
  }

  const commentRef = db.collection(`comments`).doc(comment_id);
  const commentSnapshot = await commentRef.get();

  // Kiểm tra xem tài liệu comment có tồn tại không
  if (!commentSnapshot.exists) {
    throw new Error("Tài liệu comment không tồn tại.");
  }

  await commentRef.update(newComment);
  const commentData = (await commentRef.get()).data();

  //convert time
  const created_at = commentData.created_at;
  const timestamp = new firebase.firestore.Timestamp(
    created_at._seconds,
    created_at._nanoseconds
  );
  commentData.created_at = timestamp.toDate();

  const update_at = commentData.updated_at;
  const timestamp2 = new firebase.firestore.Timestamp(
    update_at._seconds,
    update_at._nanoseconds
  );
  commentData.updated_at = timestamp2.toDate();

  return commentData;
};

const deleteCommentToFb = async (
  comment_id,
  user_id,
) => {
  const commentRef = db.collection(`comments`).doc(comment_id);
  const commentSnapshot = await commentRef.get();

  // Kiểm tra xem tài liệu comment có tồn tại không
  if (!commentSnapshot.exists) {
    throw new Error("Comment is not exist.");
  }

  // Lấy user_id từ tài liệu comment
  const commentData = commentSnapshot.data();
  const commentUserId = commentData.user_id;

  // Kiểm tra xem user_id từ tài liệu comment có trùng khớp với user_id được cung cấp không
  if (commentUserId === user_id) {
    // Xóa tài liệu comment
    await commentRef.delete();
    return true;
  } else {
    return false;
  }
};

const getCommentsByCommentId = async (pr_id = null, post_id) => {
  let commentRef = db.collection("comments").where("post_id", "==", post_id);
  const docSnapshot = await commentRef.get();

  const comments = [];

  for (const doc of docSnapshot.docs) {
    const commentData = doc.data();
    commentData.comment_id = doc.id;

    try {
      console.log("dang lay");
      // Gọi hàm lấy thông tin avatar và user_name từ user_id
      const { avatar, user_name } = await getUserAvatarAndNameByUserId(commentData.user_id);

      // Gán thông tin avatar và user_name vào commentData
      commentData.avatar = avatar;
      commentData.user_name = user_name;

      console.log(`dang lay ${avatar} ${user_name}`);
    } catch (error) {
      // Xử lý lỗi nếu không thể lấy thông tin từ user_id
      console.error(`Error fetching avatar and name for user with ID ${commentData.user_id}: ${error.message}`);
      commentData.avatar = null;
      commentData.user_name = 'Unknown';
    }

    comments.push(commentData);
  }

  // Trả về danh sách các comment đã được bổ sung avatar và user_name
  return comments;
};


module.exports = {
  getCommentsByCommentId,
  createCommentToFb,
  updateCommentToFb,
  deleteCommentToFb,
  checkCommentExists,
};
