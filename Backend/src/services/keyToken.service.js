const { createKeyToken } = require('../dbs/init.pg.js'); 
 class KeyTokenService {

     static createKeyToken = async ({ userId, publicKey }) => {
          try {
               const publicKeyString = publicKey.toString();
               const tokens = createKeyToken(userId, publicKeyString)
          } catch (error) {
               
          }
     }
 }