const db = require('./init.db.js');

const createKeyToken = async ({ userId, publicKey, privateKey, refreshToken }) => {
     const query =  `INSERT INTO token_keys (user_id, public_key, private_key, refresh_token)
     VALUES ($1, $2, $3, $4)
     ON CONFLICT (user_id) DO UPDATE SET
       public_key = EXCLUDED.public_key,
       private_key = EXCLUDED.private_key,
       refresh_token = EXCLUDED.refresh_token,
       refresh_tokens_used = array_append(token_keys.refresh_tokens_used, EXCLUDED.refresh_token)
     RETURNING *`;
     const values = [userId, publicKey, privateKey, refreshToken];

     console.log(values);

     const result = await db.query(query, values);

     console.log("ket qua check mai", result ? result : "deo co");
     
     return result;
};

module.exports = createKeyToken