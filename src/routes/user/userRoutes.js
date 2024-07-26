// src/routes/userRoutes.js
const express = require('express');
const router = express.Router();
const userController = require('../../controllers/userController');
const validateUser = require('../../middlewares/validateUser');

router.post('/register', validateUser, userController.registerUser);
router.post('/login', validateUser, userController.loginUser);

module.exports = router;
