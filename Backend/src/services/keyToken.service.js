const createKeyToken = require("../dbs/init.pg.token.js");
class KeyTokenService {
  // create token here
  static createKeyToken = async ({
    userId,
    publicKey,
    privateKey,
    refreshToken,
  }) => {
    console.log(userId, publicKey, privateKey, refreshToken);
    try {
      const tokens = await createKeyToken({
        userId: userId,
        publicKey: publicKey,
        privateKey: privateKey,
        refreshToken: refreshToken,
      });

      return tokens ? tokens.publickey : null;
    } catch (error) {
      console.log(error);
      return null;
    }
  };
}

module.exports = KeyTokenService;
