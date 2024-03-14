
const { checkUserByEmail, signUpUser } = require('../dbs/init.pg.js');
const bcrypt = require('bcrypt')
const crypto = require('crypto');
const User = require('../models/userModel.js');

const roleAccount = {
  student: 'student',
  lecture: 'lecture',
  department: 'department'
}

class AccessService {
     static async signUp({id, name, email, password }) {
          try {
            // Check if user already exists
            const existingUser = await AccessService.checkUserExists(email);
            if (existingUser) {
              return {
                code: 'xxx',
                message: 'A user with this email address already exists.',
               //  status: 'error',
               //  statusCode: 409,
              };
            }
      
            // Hash password using bcrypt (replace with your preferred hashing method)
            const hashedPassword = await bcrypt.hash(password, 10);
      
            // Prepare SQL statement

            const newUser = new User(id= id, name= name, email= email, password= hashedPassword);
            // Execute query and return new user

            const saveUser = signUpUser(newUser.id, newUser.name, newUser.email, newUser.password, roleAccount.student)
            if (saveUser) {
              //create private and publickey

              const { privateKey, publicKey } = crypto.generateKeyPairSync('rsa', {
                modulusLength: 4096
              })

              console.log({ privateKey, publicKey })

              const publicKeyString = await KeyTokenService.createKeyToken({
                userId: saveUser.id,
                publicKey
              })
              
            }
            
            return {
              code: 'SIGNUP_SUCCESS',
              message: 'User created successfully.',
              data: {
                id: saveUser.id,
                name: saveUser.name,
              },
              status: 'success',
              statusCode: 201,
            };
          } catch (error) {
            console.error('Error during signup:', error);
            return {
              code: 'xxx',
              message: error.message,
              status: 'error',
            };
          }
        }
      
        static async checkUserExists(email) {
          const result = await checkUserByEmail(email);
          return result.length;
        }
}


module.exports = AccessService;