class KeyToken {
     constructor(id, user, publicKey, refreshToken, timestamp) {
          this.id = id;
          this.user = user;
          this.publicKey = publicKey;
          this.refreshToken = refreshToken;
          this.timestamp = timestamp;
        }   
   }
   
module.exports = KeyToken;
   