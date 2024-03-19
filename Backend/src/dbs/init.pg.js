const db = require('./init.db.js');

const checkUserByEmail = async (email) => {
     const query = `SELECT * FROM users WHERE email = $1`;
     const values = [email];
     return await db.query(query, values);
};
   
   const signUpUser = async (id, name, email, password, role) => { 
     const query = ` INSERT INTO users (id, name, email, password, role, created_at, updated_at)
     VALUES ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
     RETURNING *`;
     const values = [id, name, email, password, role];
     const result = await db.query(query, values);
     return result.rows
   };

   // Create a new key token
  async function createKeyToken(id_user, publicKey) {

    const query = `INSERT INTO key_tokens (id_user, publicKey) VALUES ($1, $2) RETURNING *`;
    const values = [id_user, publicKey, refreshToken];
    const result = await executeQuery(query, values);
    return result[0];
    console.log(result);
  }

   
   module.exports = {
     checkUserByEmail,
     signUpUser,
     createKeyToken
   };
   
