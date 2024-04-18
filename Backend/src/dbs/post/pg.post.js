const db = require("../init.db.js");

// Create new post
const createPost = async (content, userId, privacy, postType, attachment) => {
  console.log(content, userId, privacy, postType, attachment);
  const query = `
      INSERT INTO Post (content, user_id, privacy, post_type, created_at)
      VALUES ($1, $2, $3, $4,CURRENT_TIMESTAMP) RETURNING *;
    `;
  const values = [content, userId, privacy, postType];
  const result = await db.query(query, values);
  console.log(result);
  return result[0];
};

// Get post
const getPostById = async (postId) => {
  const query = `SELECT * FROM Post WHERE post_id = $1`;
  const values = [postId];
  const result = await db.query(query, values);
  return result[0] || null;
};
//update here
const updatePostByIdAndUserId = async (postId, userId, updatedFields) => {
  console.log(postId, userId, updatedFields);
  let query = `UPDATE Post SET `;
  const values = [];
  let index = 1;

  // builds an update SQL statement based on the specified fields
  for (const field in updatedFields) {
    query += `${field} = $${index}, `;
    values.push(updatedFields[field]);
    index++;
  }

  // Thêm điều kiện cập nhật cho bài viết có post_id và user_id tương ứng
  query += `updated_at = CURRENT_TIMESTAMP WHERE post_id = $${index} AND user_id = $${index + 1}`;

  // Thêm giá trị của post_id và user_id vào mảng values
  values.push(postId);
  values.push(userId);

  // Thực hiện câu lệnh cập nhật và trả về kết quả
  const result = await db.query(`${query} RETURNING *`, values);

  console.log("result", result);
  return result[0];
};

// Delete post by post_id
const deletePostById = async (postId, userId) => {
  try {
      const query = `SELECT delete_post_and_attachments($1, $2)`;
      const result = await db.query(query, [postId, userId]);
      console.log("result", result);
      return result;
  } catch (error) {
      console.error('Error deleting post and attachments:', error);
      throw error;
  }
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
const updatePostContent = async (postId, newContent) => {
  const query = `
    UPDATE Post
    SET content = $1, updated_at = CURRENT_TIMESTAMP
    WHERE post_id = $2
    RETURNING *;
  `;
  const values = [newContent, postId];
  const result = await db.query(query, values);
  return result.rows[0];
};

// Cập nhật quyền riêng tư của bài đăng
const updatePostPrivacy = async (postId, newPrivacy) => {
  const query = `
    UPDATE Post
    SET privacy = $1, updated_at = CURRENT_TIMESTAMP
    WHERE post_id = $2
    RETURNING *;
  `;
  const values = [newPrivacy, postId];
  const result = await db.query(query, values);
  return result.rows[0];
};


// Cập nhật loại bài đăng
const updatePostType = async (postId, newPostType) => {
  const query = `
    UPDATE Post
    SET post_type = $1, updated_at = CURRENT_TIMESTAMP
    WHERE post_id = $2
    RETURNING *;
  `;
  const values = [newPostType, postId];
  const result = await db.query(query, values);
  return result[0];
};
const updateAttachmentFileUrl = async (attachmentId, newFileUrl) => {

    // Thực hiện truy vấn SQL để cập nhật đường dẫn file mới cho attachment
    const query = `
      UPDATE Attachment
      SET file_url = $1
      WHERE attachment_id = $2
      RETURNING *;
    `;
    const values = [newFileUrl, attachmentId];
    const result = await db.query(query, values);

    // In kết quả ra console để kiểm tra
    console.log("result", result);

    // Trả về kết quả sau khi cập nhật
    return result[0];
 
};


module.exports = {
  createPost,
  getPostById,
  deletePostById,
  updatePost,
  updatePostContent,
  updatePostPrivacy,
  updatePostType,
  updatePostByIdAndUserId,
  updateAttachmentFileUrl
};
