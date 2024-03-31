//constructor keytoken

class KeyToken {
     constructor(id, user, publicKey, privateKey, refreshToken,timestamp) {
          this.id = id;
          this.user = user;
          this.privateKey = privateKey;
          this.publicKey = publicKey;
          this.refreshToken = refreshToken;
          this.refreshTokenUsed = [],
          this.timestamp = timestamp;
        }   
   }
   
module.exports = KeyToken;
   