const{ checkUserByEmail, findUserByEmail } = require('../../dbs/access/pg.access')

 async function checkRoleEmail(email) {
          return email.endsWith("vku.udn.vn") ? true : false;
     }

     async function  checkMailUserExists(email) {
          console.log("email in service: ", email);
          return await checkUserByEmail(email);
     }

     async function  findUserByEmail(email) {
          console.log("email in service: ", email);
          return await findUserByEmail(email);
     }

     module.exports = {
          checkRoleEmail, checkMailUserExists, findUserByEmail
     }