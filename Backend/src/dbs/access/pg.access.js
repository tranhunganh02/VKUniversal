const db = require('../init.db.js');

const checkUserByEmail = async (email) => {
  console.log("email in db ", email);
     const query = `SELECT EXISTS(SELECT 1 FROM users WHERE email = $1)`;
     const values = [email];
     const result = await db.query(query, values);

     console.log("ket qua check mai", result ? result : "co roi");
     
     return result[0].exists;
};
const findUserByEmail = async (email) => {
     const query = `SELECT user_id, email, password FROM users WHERE email = $1`;
     const values = [email];
     const result = await db.query(query, values);
     
     return result[0];
};
   
   const signUpUser = async ( email, password, role) => { 
    console.log(email);
     const query = `INSERT INTO users ( email, password, role, created_at)
     VALUES ($1, $2, $3, CURRENT_TIMESTAMP)
     RETURNING *`;
     const values = [email, password, role];
     const result = await db.query(query, values);
     console.log(result[0]);
     return result[0]
   };

   // Create a new key token
  async function createNewKeyToken(id_user, publicKey, privateKey) {

    const query = `INSERT INTO key_tokens (id_user, publicKey, privateKey) VALUES ($1, $2, $3) RETURNING *`;
    const values = [id_user, publicKey, privateKey];
    const result = await db.query(query, values);
    return result[0];
  }

   
   module.exports = {
     checkUserByEmail,
     signUpUser,
     createNewKeyToken,
     findUserByEmail
   };
   
