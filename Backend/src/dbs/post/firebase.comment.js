const firebase = require('firebase-admin');
const db = firebase.firestore();

const createCommentToFb = async(postId, userId, content, image = null, level = null, path = null)  => {
    const newComment = {
      post_id: postId,
      user_id: userId,
      content: content,
      image: image,
      created_at: new Date(), // Get server timestamp
      updated_at: null, // Get server timestamp
    };

    const commentRef = level?  db.collection(`comments/${level}${path}`).doc() : db.collection(`comments`).doc()
    await commentRef.set(newComment);
    const commentData = (await commentRef.get()).data()

    //convert time
    const created_at = commentData.created_at;
    const timestamp = new firebase.firestore.Timestamp(created_at._seconds, created_at._nanoseconds);
    commentData.created_at = timestamp.toDate();

    return commentData;
}

module.exports = {createCommentToFb}