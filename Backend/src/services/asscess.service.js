const { signUpUser } = require("../dbs/init.pg.js");
const bcrypt = require("bcrypt");
const crypto = require("node:crypto");
const User = require("../models/userModel.js");
const KeyTokenService = require("./keyToken.service.js");
const { createTokenPair, checkRoleEmail } = require("../auth/authUtils.js");
const { getInfoData } = require("../utils/index.js");
const { BadRequestError, AuthFailureError } = require("../core/error.response.js");
const UserService = require("./user.service.js");

const roleAccount = {
  student: "student",
  lecture: "lecture",
  department: "department",
};

class AccessService {

  /*

    1 -check email
    2 - create AT vs RT and save
    3 - generate tokens
    4 - get data return login

  */

  static login = async({  email, password, refreshToken = null}) => {
    
    //1.Check if mail user already exists
    const foundUser = await UserService.checkMailUserExists(email)
    if(!foundUser) throw new BadRequestError('User not found')

    //2.Check macth password
    const matchPassword = await bcrypt.compare(password, foundUser.password) 
    if(!matchPassword) throw new AuthFailureError('Authentication error')

    //3.created privatedKey, publicKey 
    const privateKey = crypto.randomBytes(64).toString('hex')
    const publicKey = crypto.randomBytes(64).toString('hex')

    //4. generate token
    const tokens = await createTokenPair(
      { userId: foundUser.id, email },
      publicKey,
      privateKey
    );

    await KeyTokenService.createKeyToken({
      userId: foundUser.id,
      refreshToken: tokens.refreshToken,
      privateKey: privateKey,
      publicKey: publicKey
    })


    return {
      user: getInfoData({fileds: ['id', 'name', 'email', ], Object: foundUser}),
      tokens,
    }

  }


  static async signUp({ name, email, password }) {
    try {

      // check permisson mail vku
      const isMailVku = await UserService.checkRoleEmail(email)
      if (!isMailVku) {
       throw new BadRequestError('Error: Your email is forbidden');
      }

      // Check if mail user already exists
      const existingMailUser = await UserService.checkMailUserExists(email);
      if (existingMailUser) {
        throw new BadRequestError('Error: Email already exists')
      }
      // Hash password using bcrypt (replace with your preferred hashing method)
      const hashedPassword = await bcrypt.hash(password, 10);

      const saveUser = await signUpUser(
        name,
        email,
        hashedPassword,
        roleAccount.student
      );
      if (saveUser) {

        const privateKey = crypto.randomBytes(64).toString('hex')
        const publicKey = crypto.randomBytes(64).toString('hex')

        //create token
        const tokens = await createTokenPair(
          { userId: saveUser.id, email },
          publicKey,
          privateKey
        );

        console.log("created tokens: ", tokens);
        const keyStore = await KeyTokenService.createKeyToken({
          userId :  saveUser.id,
          publicKey : publicKey,
          privateKey : privateKey,
          refreshToken: tokens.refreshToken
      });

        //check condition publicKeyString
        if (!keyStore) {
          return {
            code: "xxxx",
            message: "publicKeyString error",
          };
        }

        return {
          code: "SIGNUP_SUCCESS",
          message: "User created successfully.",
          metadata: {
            user: getInfoData({fileds: ['id', 'name', 'email', ], Object: saveUser}),
            tokens,
          },
          status: "success",
          statusCode: 201,
        };
      }
      return {
        code: 200,
        metadata: null
      }

    } catch (error) {
      console.error("Error during signup:", error);
      return {
        code: "xxx",
        message: error.message,
        status: "error",
      };
    }
  }

}
 
module.exports = AccessService;
