const db = require('../config/db');
const bcrypt = require('bcrypt');

class UserController {
  static async registerUser(req, res) {
    const { username, password } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    const query = `INSERT INTO users (username, password) VALUES (?, ?)`;
    db.run(query, [username, hashedPassword], function (err) {
      if (err) {
        console.error(err);
        return res.status(400).json({ error: 'Username already exists' });
      }
      res.status(201).json({ id: this.lastID });
    });
  }

  static async loginUser(req, res) {
    const { username, password } = req.body;

    const query = `SELECT * FROM users WHERE username = ?`;
    db.get(query, [username], async (err, user) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Internal server error' });
      }
      if (!user) return res.status(400).json({ error: 'Invalid username or password' });

      const match = await bcrypt.compare(password, user.password);
      if (match) {
        res.json({ message: 'Login successful', userId: user.id });
      } else {
        res.status(400).json({ error: 'Invalid username or password' });
      }
    });
  }
}

module.exports = UserController;