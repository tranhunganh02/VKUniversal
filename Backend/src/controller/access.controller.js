const { CREATED, SuccessResponse} = require("../core/success.response");
const AccessService = require("../services/asscess.service");

class AccessController {
  handlerRefreshToken = async (req, res, next) => {
   //   new SuccessResponse({
   //        message: "GEt token success!!",
   //        metadata:  await AccessService.handlerRefreshToken(req.body.refreshToken)
   //   }).send(res)

   //v2 no need access token
        new SuccessResponse({
          message: "GEt token success!!",
          metadata:  await AccessService.handlerRefreshTokenV2({
            refreshToken : req.refreshToken,
            user : req.user,
            keyStore : req.keyStore
          })
     }).send(res)
  }
  login = async (req, res, next) => {
     console.log(req.body);
    new SuccessResponse({
         message: "Login sucess",
         metadata: await AccessService.login(req.body)
    }).send(res)
 };
  signUp = async (req, res, next) => {

     new CREATED({
          message: "Registerted sucess",
          metadata: await AccessService.signUp(req.body)
     }).send(res)
  };
  logout = async (req, res, next) => {

     new SuccessResponse({
          message: "Logout sucess",
          metadata: await AccessService.logout(req.keyStore)
     }).send(res)
  };
  signUpDepartment = async (req, res, next) => {

     new CREATED({
          message: "Registerted sucess",
          metadata: await AccessService.signUpDerpartment(req.body)
     }).send(res)
  };
}

module.exports = new AccessController();
