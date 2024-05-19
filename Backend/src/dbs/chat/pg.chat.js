const db = require("../init.db.js");

// Create new post
const checkMutualFollow = async (user1_id, user2_id) => {
     const query = `
         SELECT EXISTS (
             SELECT 1
             FROM follow
             WHERE follower_id = $1 AND followed_id = $2
         ) AS user1_follows_user2,
         EXISTS (
             SELECT 1
             FROM follow
             WHERE follower_id = $2 AND followed_id = $1
         ) AS user2_follows_user1;
     `;
     const values = [user1_id, user2_id];

         const result = await db.query(query, values);
         const user1_follows_user2 = result[0].user1_follows_user2;
         const user2_follows_user1 = result[0].user2_follows_user1;
         return user1_follows_user2 && user2_follows_user1; // Trả về true nếu cả hai người đều follow lẫn nhau
    
 };
 


module.exports = {
     checkMutualFollow,
 
};
