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

const updateAttachmentFileUrl = async (attachmentId, newFileUrl) => {
  try {
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
  } catch (error) {
    console.error('Error updating attachment file url:', error);
    throw new Error('Error updating attachment file url');
  }
};

module.exports = {
  createAttachment,
  updateAttachmentFileUrl
};
