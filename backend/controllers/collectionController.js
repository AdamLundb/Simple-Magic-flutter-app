const db = require('../config/db');

class CollectionController {
  static async addCardToCollection(req, res) {
    console.log('Request received:', req.body);
    const { userId, cardName, setName, isFoil, quantity } = req.body;
    db.run(
      `INSERT INTO collection (user_id, card_name, set_name, is_foil, quantity)
       VALUES (?, ?, ?, ?, ?)
       ON CONFLICT(user_id, card_name, set_name, is_foil)
       DO UPDATE SET quantity = quantity + ?`,
      [userId, cardName, setName, isFoil, quantity, quantity],
      (err) => {
        if (err) {
          console.error('Error adding card to collection:', err);
          res.status(500).json({ error: 'Failed to add card to collection' });
        } else {
          res.status(200).json({ message: 'Card added successfully' });
        }
      }
    );
  }

  static async viewCollection(req, res) {
    const userId = req.params.userId;
    db.all(
      `SELECT card_name, set_name, is_foil, quantity
       FROM collection
       WHERE user_id = ?`,
      [userId],
      (err, rows) => {
        if (err) {
          console.error('Error fetching collection:', err);
          res.status(500).json({ error: 'Failed to fetch collection' });
        } else {
          res.status(200).json(rows);
        }
      }
    );
  }

  static async deleteCardFromCollection(req, res) {
    const { userId, cardName, setName, isFoil } = req.body;
    db.run(
      `DELETE FROM collection
       WHERE user_id = ? AND card_name = ? AND set_name = ? AND is_foil = ?`,
      [userId, cardName, setName, isFoil],
      (err) => {
        if (err) {
          console.error('Error deleting card from collection:', err);
          res.status(500).json({ error: 'Failed to delete card from collection' });
        } else {
          res.status(200).json({ message: 'Card deleted successfully' });
        }
      }
    );
  }
}

module.exports = CollectionController;