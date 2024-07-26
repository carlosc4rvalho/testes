// src/routes/grapeRoutes.js
const express = require('express');
const router = express.Router();
const grapeController = require('../controllers/grapeController');

router.get('/', grapeController.getAllGrapes);
router.post('/', grapeController.createGrape);
router.get('/:id', grapeController.getGrapeById);
router.put('/:id', grapeController.updateGrape);
router.delete('/:id', grapeController.deleteGrape);

module.exports = router;
