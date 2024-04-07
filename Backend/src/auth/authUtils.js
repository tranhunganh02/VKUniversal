const JWT = require('jsonwebtoken')

const createTokenPair = async (payload, publicKey, privateKey) => {
     try {
          // access token
          
          const asscessToken = await JWT.sign(payload, publicKey, {
               expiresIn: '2m'
          })

          const refreshToken = await JWT.sign(payload, privateKey, {
               expiresIn: '1 days'
          })

          JWT.verify(asscessToken, publicKey, (err, decode) => {
               if(err) console.log('error verifying token', err);
               else console.log('decode verified token', decode)
          })

          return { asscessToken, refreshToken}

     } catch (error) {
          
     }
}
// Xác thực accessToken với Google
const checkTokenGoogle = async (accessToken)=> {
     const ticket = await client.verifyIdToken({
          idToken: accessToken,
          audience: process.env.O_AUTH_CLIENT_ID, // Thay thế YOUR_CLIENT_ID bằng Client ID của ứng dụng của bạn
        });
     return ticket
}


module.exports = {
     createTokenPair,
     checkTokenGoogle
}