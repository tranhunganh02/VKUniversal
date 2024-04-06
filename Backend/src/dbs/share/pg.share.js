const db = require("../init.db.js");

const createPostShare = async ({ shareId, postId, userId, content }) => {
       const query = `
         INSERT INTO PostShare (share_id, post_id, user_id, content)
         VALUES ($1, $2, $3, $4);
       `;
       const values = [shareId, postId, userId, content];
       await db.query(query, values);

};

const deletePostShareById = async (shareId, user_id) => {
     const query = `DELETE FROM PostShare WHERE share_id = $1 and user_id = $2`;
     const values = [shareId, user_id];
     await db.query(query, values);
};

module.exports = { createPostShare, deletePostShareById};