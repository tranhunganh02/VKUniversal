const { Pool } = require('pg');
const { db } = require('../configs/config.pg')
class Database {

  constructor(){
     this.pg = null;
     this.connect()
  }   

  async connect(type = "pg") {
     if (type === "pg") {
          try {
            this.pool = new Pool({
              user: db.name,
              password: db.password,
              database: db.database,
              host: db.host,
              port: db.port,
              poolSize: 100, // Adjust poolSize as needed
            });
    
          await this.pool.connect(); // Use await to ensure connection is established
            console.log("Connected to PostgreSQL database successfully: ",db.database);
          } catch (error) {
            console.error("Error connecting to database:", error);
            // Handle connection errors appropriately (e.g., retry, exit gracefully)
          }
        } else {
          throw new Error(`Unsupported database type: ${type}`);
        }
  }

  async query(query, values = []) {
    try {
      const result = await this.pool.query(query, values);
      console.log("cau lenh truy van", query);
      return result.rows;
    } catch (error) {
      console.error('Error executing query:', error);
      throw error; // Re-throw for handling in AccessService
    }
  }

  static getInstance() {
     if (!this.instance) {
          this.instance = new Database();
        }
        return this.instance;
      
  }



}

module.exports = Database.getInstance();


   

//     admin.initializeApp({
//       credential: admin.credential.cert(serviceAccountKeyPath),
//       databaseURL: firebaseDatabaseURL,
//     });

//     this.firebase = admin.database();
  

//   async query(type, text, params) {
//     if (type === 'postgresql') {
//       return this.pg.query(text, params);
//     } else if (type === 'firebase') {
//      //  return this.firebase.ref(text).once('value').then((snapshot) => snapshot.val());
//      return null
//     } else {
//       throw new Error(`Invalid database type: ${type}`);
//     }
//   }

  // ... other methods for connecting, disconnecting, managing transactions