const{ checkUserByEmail } = require('../dbs/init.pg')

class UserService {

     static checkRoleEmail(email) {
          return email.endsWith("vku.udn.vn") ? true : false;
     }

     static async checkMailUserExists(email) {
          const result = await checkUserByEmail(email);
          return result.length > 0 ? result[0] : null;
     }

}

module.exports = UserService