const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database(process.env.DATABASE_URL, (err) => {
  if (err) console.error('Could not connect to database', err);
  else console.log('Connected to SQLite database');
});

db.serialize(() => {
    db.run(`
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT
      )
    `);
    db.run(`
      CREATE TABLE IF NOT EXISTS collection (
        user_id INTEGER NOT NULL,
        card_name TEXT NOT NULL,
        set_name TEXT NOT NULL,
        is_foil BOOLEAN NOT NULL,
        quantity INTEGER NOT NULL,
        UNIQUE (user_id, card_name, set_name, is_foil),
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    `);
    db.run(`
      CREATE TABLE IF NOT EXISTS price_history (
        user_id INTEGER NOT NULL,
        price_id INTEGER NOT NULL,
        date TEXT DEFAULT (datetime('now')),
        total_price REAL NOT NULL,
        PRIMARY KEY (user_id, price_id),
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    `);
  });

  module.exports = db;