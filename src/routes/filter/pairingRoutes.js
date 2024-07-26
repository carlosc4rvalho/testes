const express = require('express');
const router = express.Router();
const pairingController = require('../controllers/pairingController');

router.get('/', pairingController.getAllPairings);
router.post('/', pairingController.createPairing);
router.get('/:id', pairingController.getPairingById);
router.put('/:id', pairingController.updatePairing);
router.delete('/:id', pairingController.deletePairing);

module.exports = router;