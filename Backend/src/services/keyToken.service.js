const {createKeyToken, getKeyByUserId, deleteKeyById, findRefreshTokenUsed, findRefreshToken, findAndDeleteTokenByUserId, updateRefreshToken} = require("../dbs/pg.token.js");
const { v4: uuidv4 } = require('uuid');
class KeyTokenService {
  // create token here
  static createKeyToken = async ({
    userId,
    publicKey,
    privateKey,
    refreshToken,
  }) => {
    console.log(userId, publicKey, privateKey, refreshToken);
      const tokenId = uuidv4();
      const tokens = await createKeyToken({
        tokenId: tokenId,
        userId: userId,
        publicKey: publicKey,
        privateKey: privateKey,
        refreshToken: refreshToken,
      });
      return tokens
  };

  static findTokenByUserId = async ( userId ) => {
    return await getKeyByUserId(userId);
  }
  static removeTokenByTokenId = async ( id ) => {
    return await deleteKeyById(id);
  }
  static findByRefreshToken = async ( refresh_token ) => {
    return await findRefreshToken(refresh_token);
  }
  static findByRefreshTokenUsed = async ( refresh_token_used ) => {
    return await findRefreshTokenUsed(refresh_token_used);
  }
  static findAndDeleteKeyByUserId = async ( userId ) => {
    return await findAndDeleteTokenByUserId(userId);
  }
  static updateToken = async ( user_id, new_refresh_token, old_refresh_token) => {
    return await updateRefreshToken(user_id, new_refresh_token, old_refresh_token)
  }
}
 
module.exports = KeyTokenService;
