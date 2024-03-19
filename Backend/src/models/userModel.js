class User {
     constructor(id, name, email, password,  avatar = null, bio= null, role, createdAt, updatedAt) {
       this.id = id;
       this.name = name;
       this.email = email;
       this.password = password;
       this.avatar = avatar;
       this.bio = bio;
       this.role = role;
       this.createdAt = createdAt;
       this.updatedAt = updatedAt;
     }
   }
   
   module.exports = User;
   