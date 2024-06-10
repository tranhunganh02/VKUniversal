
const pro = {
     app: {
          post: process.env.PORT 
     },
     db:{
          host: process.env.PRO_DB_HOST || 'localhost',
          post: process.env.PRO_DB_PORT || 5432,
          name: process.env.PRO_DB_NAME || 'postgres',
          password: process.env.PRO_DB_PASSWORD || '',
          database:   process.env.PRO_DB_DATABASE || 'vkuniversal'
     }
}

const env = 'pro'
const config = { pro }
console.log(config[env], env);
module.exports = config[env]