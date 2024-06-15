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
  const query = `SELECT p.*, a.attachment_id, a.file_url
  FROM Post p
  LEFT JOIN Attachment a ON p.post_id = a.post_id
  WHERE p.post_id = $1;`;
  const values = [postId];
  const result = await db.query(query, values);
  return result || null;
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
  query += `updated_at = CURRENT_TIMESTAMP WHERE post_id = $${index} AND user_id = $${
    index + 1
  }`;

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
    console.error("Error deleting post and attachments:", error);
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
  return result[0];
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
  return result[0];
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

  // Trả về kết quả sau khi cập nhật
  return result[0];
};
const getLatestPostsFollowed = async (page, user_id) => {
  const limit = 6;
  const offset = (page - 1) * limit;
  
  const query = `
    WITH UserRoles AS (
      SELECT 
        u.user_id,
        u.role,
        u.avatar,
        COALESCE(
          CASE 
            WHEN u.role = 1 THEN CONCAT(s.surname, ' ', s.last_name)
            WHEN u.role = 2 THEN CONCAT(l.surname, ' ', l.last_name)
            WHEN u.role = 3 THEN d.department_name
          END,
          'Unknown'
        ) AS user_name
      FROM users u
      LEFT JOIN student s ON u.user_id = s.user_id AND u.role = 1
      LEFT JOIN lecturer l ON u.user_id = l.user_id AND u.role = 2
      LEFT JOIN department d ON u.user_id = d.user_id AND u.role = 3
    ),
    PostLikes AS (
      SELECT 
        pl.post_id,
        COUNT(*)::int AS like_count
      FROM Post_like pl
      GROUP BY pl.post_id
    ),
    PostAttachments AS (
      SELECT 
        a.post_id,
        COALESCE(
          json_agg(json_build_object('file_url', a.file_url, 'file_name', a.file_name, 'file_type', a.file_type)) FILTER (WHERE a.file_url IS NOT NULL),
          '[]'::json
        ) AS image_urls
      FROM Attachment a
      GROUP BY a.post_id
    )
    SELECT 
      p.user_id, 
      p.post_id, 
      p.content, 
      p.created_at, 
      p.updated_at, 
      ur.avatar,
      ur.user_name,
      COALESCE(pl.like_count, 0) AS like_count,
      EXISTS (
        SELECT 1
        FROM Post_like pl
        WHERE pl.user_id = $1 AND pl.post_id = p.post_id
      ) AS liked_by_user,
      pa.image_urls
    FROM post p
    JOIN UserRoles ur ON p.user_id = ur.user_id
    LEFT JOIN PostLikes pl ON p.post_id = pl.post_id
    LEFT JOIN PostAttachments pa ON p.post_id = pa.post_id
    WHERE p.user_id IN (
        SELECT followed_id
        FROM follow
        WHERE follower_id = $1
    )
    ORDER BY p.created_at DESC
    LIMIT $2 OFFSET $3;
  `;

  const values = [user_id, limit, offset];
  const result = await db.query(query, values);

  return result;
};


const getLatestPostsByDepartment = async (
  order = Math.floor(Math.random() * 8) + 1,
  offset = 0
) => {
  const query = `
    WITH OrderedDepartments AS (
      SELECT user_id, ROW_NUMBER() OVER (ORDER BY department_id) as row_num
      FROM department
    )
    SELECT p.post_id, p.title, p.content, p.created_at, p.updated_at, d.department_name
    FROM post p
    JOIN OrderedDepartments od ON p.user_id = od.user_id
    LEFT JOIN department d ON p.user_id = d.user_id
    WHERE od.row_num = $1
    ORDER BY p.created_at DESC
    LIMIT 2 OFFSET $2;  
  `;

  const values = [order, offset];
  const result = await db.query(query, values);

  return result;
};

const getLatestPosts = async (page, user_id) => {
  console.log(user_id);
  const limit = 6;
  const offset = (page - 1) * limit;

  const query = `
    WITH UserRoles AS (
      SELECT 
        u.user_id,
        u.role,
        u.avatar,
        COALESCE(
          CASE 
            WHEN u.role = 1 THEN CONCAT(s.surname, ' ', s.last_name)
            WHEN u.role = 2 THEN CONCAT(l.surname, ' ', l.last_name)
            WHEN u.role = 3 THEN d.department_name
          END,
          'Unknown'
        ) AS user_name
      FROM users u
      LEFT JOIN student s ON u.user_id = s.user_id AND u.role = 1
      LEFT JOIN lecturer l ON u.user_id = l.user_id AND u.role = 2
      LEFT JOIN department d ON u.user_id = d.user_id AND u.role = 3
    ),
    PostLikes AS (
      SELECT 
        pl.post_id,
        COUNT(*)::int AS like_count
      FROM Post_like pl
      GROUP BY pl.post_id
    ),
    PostAttachments AS (
   SELECT 
        a.post_id,
        COALESCE(
            json_agg(json_build_object('file_url', a.file_url, 'file_name', a.file_name, 'file_type', a.file_type)) FILTER (WHERE a.file_url IS NOT NULL),
            '[]'::json
        ) AS image_urls
    FROM Attachment a
    GROUP BY a.post_id
    )
    SELECT 
      p.user_id, 
      p.post_id, 
      p.content, 
      p.created_at, 
      p.updated_at, 
      ur.avatar, 
      ur.role,
      ur.user_name,
      COALESCE(pl.like_count, 0) AS like_count,
      EXISTS (
        SELECT 1
        FROM Post_like pl
        WHERE pl.user_id = $1 AND pl.post_id = p.post_id
      ) AS liked_by_user,
      pa.image_urls
    FROM post p
    JOIN UserRoles ur ON p.user_id = ur.user_id
    LEFT JOIN PostLikes pl ON p.post_id = pl.post_id
    LEFT JOIN PostAttachments pa ON p.post_id = pa.post_id
    WHERE p.privacy = false
    ORDER BY p.created_at DESC
    LIMIT $2 OFFSET $3;
  `;
  
  const values = [user_id, limit, offset];
  const result = await db.query(query, values);
  return result;
};


const getLatestPostsByField = async (field, page = 1, user_id) => {
  const limit = 6;
  const offset = (page - 1) * limit;

  console.log("s", field);

  const query = `
    WITH UserRoles AS (
      SELECT 
        u.user_id,
        u.role,
        u.email,
        COALESCE(
          CASE 
            WHEN u.role = 1 THEN CONCAT(s.surname, ' ', s.last_name)
            WHEN u.role = 2 THEN CONCAT(l.surname, ' ', l.last_name)
            WHEN u.role = 3 THEN d.department_name
          END,
          'Unknown'
        ) AS user_name
      FROM users u
      LEFT JOIN student s ON u.user_id = s.user_id AND u.role = 1
      LEFT JOIN lecturer l ON u.user_id = l.user_id AND u.role = 2
      LEFT JOIN department d ON u.user_id = d.user_id AND u.role = 3
    ),
    PostLikes AS (
      SELECT 
        pl.post_id,
        COUNT(*)::int AS like_count
      FROM Post_like pl
      GROUP BY pl.post_id
    ),
    PostAttachments AS (
      SELECT 
        a.post_id,
        COALESCE(
          STRING_AGG(a.file_url, ', ') FILTER (WHERE a.file_url IS NOT NULL),
          'No image'
        ) AS image_urls
      FROM Attachment a
      GROUP BY a.post_id
    )
    SELECT 
      p.post_id, 
      p.content, 
      p.created_at, 
      ur.email,
      COALESCE(pl.like_count, 0) AS like_count,
      EXISTS (
        SELECT 1
        FROM Post_like pl
        WHERE pl.user_id = $1 AND pl.post_id = p.post_id
      ) AS liked_by_user,
      ur.user_name,
      pa.image_urls
    FROM post p
    JOIN UserRoles ur ON p.user_id = ur.user_id
    LEFT JOIN PostLikes pl ON p.post_id = pl.post_id
    LEFT JOIN PostAttachments pa ON p.post_id = pa.post_id
    WHERE 
      p.content ILIKE '%' || $2 || '%' OR ur.email LIKE '%' || $2 || '%'
    ORDER BY p.post_id DESC
    LIMIT $3 OFFSET $4;
  `;
  
  const values = [user_id, field, limit, offset];
  const result = await db.query(query, values);
  return result;
};


const likePost = async (post_id, user_id) => {
  const queryCheck = "  SELECT 1 FROM Post_like WHERE user_id = $2 AND post_id = $1 "
  const valuesCheck = [post_id, user_id];
  const resultCheck = await db.queryGetRowCount(queryCheck, valuesCheck)
  if (resultCheck == 0) {
    const query = 'INSERT INTO Post_like (post_id, user_id) VALUES ($1, $2)';
  const values = [post_id, user_id];
  
  const result = await db.queryGetRowCount(query, values);
  
  return result == 1 ?  true :  false
  } else {
    return false
  }
  
};

const unlikePost = async (post_id, user_id) => {
  const query = 'DELETE FROM Post_like WHERE post_id = $1 AND user_id = $2';
  const values = [post_id, user_id];
  
  const result = await db.queryGetRowCount(query, values);
  
  return result == 1 ?  true :  false
  
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
  updateAttachmentFileUrl,
  getLatestPostsByDepartment,
  getLatestPostsFollowed,
  getLatestPosts,
  getLatestPostsByField,
  likePost,
  unlikePost
};