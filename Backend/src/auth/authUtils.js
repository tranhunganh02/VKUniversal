const JWT = require('jsonwebtoken')
const asyncHandler = require('../helper/asyncHandler')
const { AuthFailureError, NotFoundError, UnauthorizedError } = require('../core/error.response')
const { findTokenByUserId } = require('../services/keyToken.service')

const HEADER = {
     CLIENT_ID: 'x-client-id',
     AUTHORIZATION: 'authorization',
     REFRESH_TOKEN: 'x-rtoken-id',
}

const createTokenPair = async (payload, publicKey, privateKey) => {
     console.log('payload: ', payload);
     try {
          // access token
          
          const asscessToken = await JWT.sign(payload, publicKey, {
               expiresIn: '30m'
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
// // Xác thực accessToken với Google
// const checkTokenGoogle = async (accessToken)=> {
//      const ticket = await client.verifyIdToken({
//           idToken: accessToken,
//           audience: process.env.O_AUTH_CLIENT_ID, // Thay thế YOUR_CLIENT_ID bằng Client ID của ứng dụng của bạn
//         });
//      return ticket
// }

const authentication = asyncHandler ( async (req, res, next) => {
     /**
      * 1 check userId missing?
      * 2 get accessToken
      * 3 verifyToken
      * 4 Ok all => next()
      */

     console.log(req.headers['x-client-id']);

     const userId = req.headers['x-client-id']
     if (!userId)  throw new AuthFailureError('Invalid request')

     const keyStore = await findTokenByUserId(userId)
     if(!keyStore) throw new NotFoundError('Not found keyStore')

     const accessToken = req.headers.authorization
     if (!accessToken) throw new AuthFailureError('Invalid request')

     try {
          const decode = JWT.verify(accessToken, keyStore.public_key)
        
          if(userId !== decode.userId.toString()) throw new AuthFailureError('Invalid userId')
          req.keyStore = keyStore
          return next()
     } catch (error) {
          throw error
     }
})

const authenticationV2 = asyncHandler ( async (req, res, next) => {
     /**
      * 1 check userId missing?
      * 2 get token from db
      * 3 verifyToken
      * 4 Ok all => next()
      */
     console.log("in authenticate");
     //1
     const userId = req.headers[HEADER.CLIENT_ID]
     if (!userId)  throw new AuthFailureError('Invalid request')
     //2
     const keyStore = await findTokenByUserId(userId)
     if(!keyStore) throw new UnauthorizedError('Not found keyStore')

     //3
     if (req.headers[HEADER.REFRESH_TOKEN]) {
          try {
               const refreshToken = req.headers[HEADER.REFRESH_TOKEN]
               const decodeUser = JWT.verify(refreshToken, keyStore.private_key)

          if(userId !== decodeUser.userId.toString()) throw new AuthFailureError('Invalid userId')
          req.keyStore = keyStore
          req.user = decodeUser
          req.refreshToken = refreshToken
          return next()
          } catch (error) {
               throw error
          }
     }

     const accessToken = req.headers[HEADER.AUTHORIZATION]
     if (!accessToken) throw new AuthFailureError('Invalid request')

     try {
          console.log(accessToken);
          const decode = JWT.verify(accessToken, keyStore.public_key)

          if(userId !== decode.userId.toString()) throw new UnauthorizedError()

          req.keyStore = keyStore
          req.user = decode

          console.log("req.user: ", decode);
          return next()
     } catch (error) {
          throw new UnauthorizedError()
     }
})

const verifyJWT = async (token, keySecret) => {
     console.log("keySecret", keySecret);
     const result = await JWT.verify(token, keySecret)
     console.log(result);
     return result
}

module.exports = {
     createTokenPair,
     authentication,
     verifyJWT,
     authenticationV2
}