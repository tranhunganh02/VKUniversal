const JWT = require('jsonwebtoken')

const createToken = async (payload, publicKey, privateKey) => {
     try {
          // access token
          
          const asscessToken = await JWT.sign(payload, privateKey)
     } catch (error) {
          
     }
}

module.exports = {
     createToken
}