// src/controllers/grapeController.js
const GrapeService = require('../services/grapeService');

exports.getAllCategories = async (req, res) => {
  try {
    const filters = {};
    if (req.query.name) {
      filters.name = { contains: req.query.name };
    }
    const categories = await GrapeService.getAllCategories(filters);
    res.json(categories);
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve categories' });
  }
};

exports.createGrape = async (req, res) => {
  try {
    const newGrape = await GrapeService.createGrape(req.body);
    res.status(201).json(newGrape);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create grape' });
  }
};

exports.getGrapeById = async (req, res) => {
  try {
    const grape = await GrapeService.getGrapeById({ id: parseInt(req.params.id) });
    if (grape) {
      res.json(grape);
    } else {
      res.status(404).json({ error: 'Grape not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve grape' });
  }
};

exports.updateGrape = async (req, res) => {
  try {
    const updatedGrape = await GrapeService.updateGrape({ id: parseInt(req.params.id) }, req.body);
    res.json(updatedGrape);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update grape' });
  }
};

exports.deleteGrape = async (req, res) => {
  try {
    await GrapeService.deleteGrape({ id: parseInt(req.params.id) });
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete grape' });
  }
};