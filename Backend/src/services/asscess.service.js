const { signUpUser } = require("../dbs/access/pg.access.js");
const bcrypt = require("bcrypt");
const crypto = require("node:crypto");
const User = require("../models/userModel.js");
const KeyTokenService = require("./keyToken.service.js");
const { createTokenPair, verifyJWT } = require("../auth/authUtils.js");
const { getInfoData } = require("../utils/index.js");
const { BadRequestError, AuthFailureError, ForbiddenError } = require("../core/error.response.js");
const UserService = require("./user.service.js");
const { includes } = require("lodash");

const roleAccount = {
  student: 0,
  lecture: 1,
  department: 2,
  admin: 3
};

class AccessService {

  static handlerRefreshTokenV2  = async ( {refreshToken, user, keyStore} ) => {

    const { userId, email } = user

    console.log("user in hander", userId, email);

    if(keyStore.refresh_tokens_used.includes(refreshToken)){
      await KeyTokenService.findAndDeleteKeyByUserId(userId)
  
      throw new ForbiddenError("Something went wrong ! Please relogin")
    }

    if(keyStore.refresh_token !== refreshToken) throw new AuthFailureError('Account not registered.')


     //create new access token and refresh token
     const tokens = await createTokenPair(
      { userId: userId, email: email },
      keyStore.public_key,
      keyStore.private_key
    );
    //update token
    await KeyTokenService.updateToken(userId, tokens.refreshToken, refreshToken)

    //update token in db
    return {
      user,
      tokens
    }
  }

  static handlerRefreshToken  = async ( refreshToken ) => {
  //check token_used?
    const foundToken = await KeyTokenService.findByRefreshTokenUsed(refreshToken)
    //if found
    if (foundToken) {
      console.log("token_refresh_used", foundToken);
     //decode check user 
      const { userId, email } = await verifyJWT (refreshToken,foundToken.private_key)
      //delete token in db
      await KeyTokenService.findAndDeleteKeyByUserId(userId)

      throw new ForbiddenError("Something went wrong ! Please relogin")
    }
    console.log("not found");
    
    //if not found -> check refresh token
    const holdderToken = await KeyTokenService.findByRefreshToken(refreshToken)
    if (!holdderToken) throw new AuthFailureError('Account not registered.')
    console.log("holdderToken", holdderToken);

    //check email and userId from request and privateKey(db)
    const { userId, email } = await verifyJWT ( refreshToken, holdderToken.private_key )

    //create new access token and refresh token
    const tokens = await createTokenPair(
      { userId: userId, email: email },
      holdderToken.public_key,
      holdderToken.private_key
    );
    //update token
    await KeyTokenService.updateToken(userId, tokens.refreshToken, holdderToken.refreshToken)

    //update token in db
    return {
      user: {userId, email},
      tokens
    }
  }

  static logout = async (keyStore) => {
    console.log("vo toi logout r," ,keyStore);
    const delKey = await KeyTokenService.removeTokenByTokenId(keyStore.token_id)

    console.log(delKey);
    if (!delKey) {
      throw new BadRequestError('Error: Bản ghi không được tìm thấy trong bảng')
    }

    return {
      success: true,
      message: `bản ghi đã được xóa khỏi bảng`
    }
  }


  /*

    1 -check email
    2 - create AT vs RT and save
    3 - generate tokens
    4 - get data return login

  */

  static login = async({  email, password }) => {
    console.log(email, password);
    //1.Check if mail user already exists
    const foundUser = await UserService.findUserByEmail(email)
    if(!foundUser) throw new BadRequestError('User not found')

    console.log("found user ", foundUser);

    //2.Check macth password
    const matchPassword = await bcrypt.compare(password, foundUser.password) 
    if(!matchPassword) throw new AuthFailureError('Authentication error')

    //3.created privatedKey, publicKey 
    const privateKey = crypto.randomBytes(64).toString('hex')
    const publicKey = crypto.randomBytes(64).toString('hex')

    //4. generate token
    const tokens = await createTokenPair(
      { userId: foundUser.user_id, email },
      publicKey,
      privateKey
    );

    await KeyTokenService.createKeyToken({
      userId: foundUser.user_id,
      refreshToken: tokens.refreshToken,
      privateKey: privateKey,
      publicKey: publicKey
    })


    return {
      user: getInfoData({fileds: ['user_id', 'email', ], Object: foundUser}),
      tokens,
    }

  }


  static async signUp({ email, password }) {

      console.log("email: " + email);
      // check permisson mail vku
      const isMailVku = await UserService.checkRoleEmail(email)
      if (!isMailVku) {
      console.log("email: " + email);
       throw new ForbiddenError('Error: Your email is forbidden');
      }
      // Check if mail user already exists
      const existingMailUser = await UserService.checkMailUserExists(email);
      if (existingMailUser) {
      console.log("email: " + email);
        throw new BadRequestError('Error: Email already exists')
      }
      // Hash password using bcrypt (replace with your preferred hashing method)
      const hashedPassword = await bcrypt.hash(password, 10);

      console.log("email: " + email);
      const saveUser = await signUpUser(
        email,
        hashedPassword,
        roleAccount.student
      );
      if (saveUser) {

        const privateKey = crypto.randomBytes(64).toString('hex')
        const publicKey = crypto.randomBytes(64).toString('hex')

        //create token
        const tokens = await createTokenPair(
          { userId: saveUser.user_id, email },
          publicKey,
          privateKey
        );

        console.log("created tokens: ", tokens);
        const keyStore = await KeyTokenService.createKeyToken({
          userId :  saveUser.user_id,
          publicKey : publicKey,
          privateKey : privateKey,
          refreshToken: tokens.refreshToken
      });

        if (!keyStore) {
          throw new BadRequestError("publicKeyString error")
        }

        return {
            user: getInfoData({fileds: ['user_id', 'email', ], Object: saveUser}),
            tokens,
        };
      }
  }

}
 
module.exports = AccessService;
