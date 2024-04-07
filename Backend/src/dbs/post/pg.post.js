const db = require("../init.db.js");

// Create new post
const createPost = async ({ postId, content, userId, privacy, postType, createdAt, updatedAt }) => {
 
    const query = `
      INSERT INTO Post (post_id, content, user_id, privacy, post_type, created_at, updated_at)
      VALUES ($1, $2, $3, $4, $5, $6, $7);
    `;
    const values = [postId, content, userId, privacy, postType, createdAt, updatedAt];
    await db.query(query, values);

};

// Get post
const getPostById = async (postId) => {
 
    const query = `SELECT * FROM Post WHERE post_id = $1`;
    const values = [postId];
    const result = await db.query(query, values);
    return result[0] || null;
  
    
};

// Delete post by post_id
const deletePostById = async (postId) => {
 
    const query = `DELETE FROM Post WHERE post_id = $1`;
    const values = [postId];
    await db.query(query, values);
  
    
};

// Update content and time of post by post_id
const updatePost = async (postId, newContent, newUpdatedAt) => {
 
    const query = `
      UPDATE Post
      SET content = $1, updated_at = $2
      WHERE post_id = $3;
    `;
    const values = [newContent, newUpdatedAt, postId];
    await db.query(query, values);
  
};

module.exports = { createPost, getPostById, deletePostById, updatePost };
