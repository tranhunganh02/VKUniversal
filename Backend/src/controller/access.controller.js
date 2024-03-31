const { CREATED, SuccessResponse} = require("../core/success.response");
const AccessService = require("../services/asscess.service");

class AccessController {
  login = async (req, res, next) => {

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
}

module.exports = new AccessController();
