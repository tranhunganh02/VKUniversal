const db = require("../init.db.js");

// Create attachment
const createAttachment = async (postId, fileName, fileType, fileUrl) => {
  const query = `
      INSERT INTO Attachment (post_id, file_name, file_type, file_url)
      VALUES ($1, $2, $3, $4) RETURNING *;
    `;
  const values = [postId, fileName, fileType, fileUrl];
  const result = await db.query(query, values);
  console.log("result", result);
  return result[0];
};

module.exports = {
  createAttachment
};
