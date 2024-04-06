const{ checkUserByEmail, findUserByEmail } = require('../dbs/access/pg.access')

class UserService {

     static checkRoleEmail(email) {
          return email.endsWith("vku.udn.vn") ? true : false;
     }

     static async checkMailUserExists(email) {
          console.log("email in service: ", email);
          return await checkUserByEmail(email);
     }

     static async findUserByEmail(email) {
          console.log("email in service: ", email);
          return await findUserByEmail(email);
     }

}

module.exports = UserService