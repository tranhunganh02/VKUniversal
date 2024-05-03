const dev = {
     app: {
          post: process.env.DEV_APP_PORT || 5055
     },
     db:{
          host: process.env.DEV_DB_HOST || "localhost",
          post: process.env.DEV_DB_POST || 5432,
          name: process.env.DEV_DB_NAME || 'postgres',
          password: process.env.DEV_DB_PASSWORD || '',
          database:   process.env.PRO_DB_DATABASE || 'vkuniversal' 
     }
}
const pro = {
     app: {
          post: process.env.PRO_APP_PORT || 5000
     },
     db:{
          host: process.env.PRO_DB_HOST || 'localhost',
          post: process.env.PRO_DB_PORT || 5432,
          name: process.env.PRO_DB_NAME || 'postgres',
          password: process.env.PRO_DB_PASSWORD || '',
          database:   process.env.PRO_DB_DATABASE || 'vkuniversal'
     }
}

const env = process.env.NODE_ENV || 'dev'
const config = { dev, pro }
console.log(config[env], env);
module.exports = config[env]