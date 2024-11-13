const express = require('express');
const UserController = require('../controllers/userController');
const router = express.Router();

// Register a new user
router.post('/register', UserController.registerUser);

// Login user
router.post('/login', UserController.loginUser);

module.exports = router;