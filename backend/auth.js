const express = require('express');
const { register, login } = require('../controllers/authController');
const router = express.Router();

// THIS LINE WAS MISSING — THIS IS WHY SIGNUP FAILED!
router.post('/register', register);
router.post('/login', login);

module.exports = router;