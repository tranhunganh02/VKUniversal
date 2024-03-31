const db = require('./init.db.js');

const checkUserByEmail = async (email) => {
     const query = `SELECT * FROM users WHERE email = $1`;
     const values = [email];
     const result = await db.query(query, values);

     console.log("ket qua check mai", result ? result : "deo co");
     
     return result;
};
   
   const signUpUser = async ( name, email, password, role) => { 
     const query = `INSERT INTO users (name, email, password, role, created_at, updated_at)
     VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
     RETURNING *`;
     const values = [name, email, password, role];
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
     createNewKeyToken
   };
   
