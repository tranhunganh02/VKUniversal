const { Pool } = require('pg');
const { db } = require('../configs/config.pg');
const admin = require('firebase-admin');
class Database {

  constructor(){
     this.pool = null;
     this.firebase = null;
     this.connect("pg");
     this.connect("firebase");
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
            console.log("Connected to PostgreSQL database successfully: ", db.database);
          } catch (error) {
            console.error("Error connecting to database:", error);
            // Handle connection errors appropriately (e.g., retry, exit gracefully)
          }
        } else if (type === "firebase") {
          try {
            this.firebase = admin.initializeApp({
              credential: admin.credential.cert({
                "type": process.env.FIREBASE_TYPE,
                "project_id": process.env.FIREBASE_PROJECT_ID,
                "private_key_id": process.env.FIREBASE_PRIVATE_KEY_ID,
                "private_key": process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'), // Restore line breaks
                "client_email": process.env.FIREBASE_CLIENT_EMAIL,
                "client_id": process.env.FIREBASE_CLIENT_ID,
                "auth_uri": process.env.FIREBASE_AUTH_URI,
                "token_uri": process.env.FIREBASE_TOKEN_URI,
                "auth_provider_x509_cert_url": process.env.FIREBASE_AUTH_PROVIDER_X509_CERT_URL,
                "client_x509_cert_url": process.env.FIREBASE_CLIENT_X509_CERT_URL
              }),
              databaseURL: process.env.DATABASE_URL,
              storageBucket: process.env.STORAGEBUCKET,
            });
            console.log("Connected to Firebase Realtime Database successfully.");
          } catch (error) {
            console.error("Error connecting to Firebase:", error);
          }
        } else {
          throw new Error(`Unsupported database type: ${type}`);
        }
  }

  async query(query, values = []) {
    try {
      const result = await this.pool.query(query, values);
      console.log("res", result.rowCount);
      return result.rows;
    } catch (error) {
      console.error('Error executing query:', error);
      throw error; // Re-throw for handling in AccessService
    }
  }
  async queryGetRowCount(query, values = []) {
    try {
      const result = await this.pool.query(query, values);
      return result.rowCount;
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
