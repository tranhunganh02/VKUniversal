const db = require("./init.db.js");

const createKeyToken = async ({
  tokenId,
  userId,
  publicKey,
  privateKey,
  refreshToken,
}) => {
  const userExistsQuery = 'SELECT 1 FROM token_keys WHERE user_id = $1';
    const userExistsValues = [userId];
    const userExistsResult = await db.query(userExistsQuery, userExistsValues);

    if (userExistsResult.length > 0) {
      // Nếu user_id đã tồn tại, thực hiện update
      const updateQuery = `
        UPDATE token_keys
        SET 
          public_key = $2,
          private_key = $3,
          refresh_token = $4,
          refresh_tokens_used = array_append(refresh_tokens_used, (SELECT refresh_token FROM token_keys WHERE user_id = $1))
        WHERE user_id = $1;
      `;
      const updateValues = [userId, publicKey, privateKey, refreshToken];
      return await db.query(updateQuery, updateValues);
    } else {
      // Nếu user_id chưa tồn tại, thực hiện insert
      const insertQuery = `
        INSERT INTO token_keys (token_id, user_id, public_key, private_key, refresh_token)
        VALUES ($1, $2, $3, $4, $5);
      `;
      const insertValues = [tokenId, userId, publicKey, privateKey, refreshToken];
      return await db.query(insertQuery, insertValues);
    }
};

const getKeyByUserId = async (userId) => {
  console.log("day ni");
  const query = `SELECT * FROM token_keys WHERE user_id = $1`;
  const values = [userId];
  const result = await db.query(query, values);
  console.log("result.row[0]", result[0]);
  return result[0] || null; // Return the first row or null if no rows found
};

const deleteKeyById = async (userId) => {
  console.log("trong db ne ", userId);
  const query = `DELETE from token_keys WHERE token_id = $1`;
  const values = [userId];
  const result = await db.query(query, values);
  return result; // Return the first row or null if no rows found
};

// Hàm kiểm tra xem refresh token đã được sử dụng chưa
const findRefreshTokenUsed = async (refreshToken) => {
  console.log("in db check token used ",refreshToken);
  const query = `
  SELECT * FROM token_keys WHERE $1 = ANY (refresh_tokens_used);
  `;
  const values = [refreshToken];
  const result = await db.query(query, values);
  console.log(result);
  return result[0];

};
const findRefreshToken = async (refreshTokenUsed) => {
  const query = `
  SELECT * FROM token_keys WHERE refresh_token = $1
  `;
  const values = [refreshTokenUsed];
  const result = await db.query(query, values);
  return result[0];

};
const findAndDeleteTokenByUserId = async (userId) => {
  const query = `
  SELECT find_and_delete_user($1)
  `;
  const values = [userId];
  const result = await db.query(query, values);

  return result;
};
const updateRefreshToken = async (user_id, new_refresh_token, old_refresh_token) => {
    // Cập nhật refresh_token mới và cập nhật refresh_tokens_used
    const updateQuery = `
      UPDATE token_keys
      SET 
        refresh_token = $1,
        refresh_tokens_used = array_append(refresh_tokens_used, $2)
      WHERE user_id = $3;
    `;
    const updateValues = [new_refresh_token, old_refresh_token, user_id];
    const result = await db.query(updateQuery, updateValues);
    return result;
};

module.exports = { createKeyToken, getKeyByUserId, deleteKeyById, findRefreshTokenUsed, findAndDeleteTokenByUserId, findRefreshToken, updateRefreshToken };
