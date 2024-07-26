// src/controllers/pairingController.js
const PairingService = require('../services/pairingService');

exports.getAllCategories = async (req, res) => {
  try {
    const filters = {};
    if (req.query.name) {
      filters.name = { contains: req.query.name };
    }
    const categories = await PairingService.getAllCategories(filters);
    res.json(categories);
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve categories' });
  }
};

exports.createPairing = async (req, res) => {
  try {
    const newPairing = await PairingService.createPairing(req.body);
    res.status(201).json(newPairing);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create pairing' });
  }
};

exports.getPairingById = async (req, res) => {
  try {
    const pairing = await PairingService.getPairingById({ id: parseInt(req.params.id) });
    if (pairing) {
      res.json(pairing);
    } else {
      res.status(404).json({ error: 'Pairing not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve pairing' });
  }
};

exports.updatePairing = async (req, res) => {
  try {
    const updatedPairing = await PairingService.updatePairing({ id: parseInt(req.params.id) }, req.body);
    res.json(updatedPairing);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update pairing' });
  }
};

exports.deletePairing = async (req, res) => {
  try {
    await PairingService.deletePairing({ id: parseInt(req.params.id) });
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete pairing' });
  }
};