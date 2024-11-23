const express = require('express');
const CollectionController = require('../controllers/collectionController');

const router = express.Router();

router.post('/collection', (req, res) => CollectionController.addCardToCollection(req, res));
router.get('/collection/:userId', (req, res) => CollectionController.viewCollection(req, res));
router.delete('/collection', (req, res) => CollectionController.deleteCardFromCollection(req, res));

module.exports = router;