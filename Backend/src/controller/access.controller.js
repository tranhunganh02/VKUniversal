const { CREATED, SuccessResponse} = require("../core/success.response");
const AccessService = require("../services/asscess.service");

class AccessController {
  handlerRefreshToken = async (req, res, next) => {
     new SuccessResponse({
          message: "GEt token success!!",
          metadata:  await AccessService.handlerRefreshToken(req.body.refreshToken)
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
}

module.exports = new AccessController();
