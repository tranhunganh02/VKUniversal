const db = require('../dbs/init.pg.js');
const User = require('../models/userModel.js');

class UserService {
  async getAllUsers() {
    const users = await db.pg.query('SELECT * FROM users');
    return users.rows.map((row) => new User(row));
  }

  async getUserById(id) {
    const user = await db.pg.query('SELECT * FROM users WHERE id = $1', [id]);
    return user.rows[0] ? new User(user.rows[0]) : null;
  }

  // ... other methods for creating, updating, deleting users
}

module.exports = new UserService();
