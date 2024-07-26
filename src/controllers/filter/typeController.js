// src/controllers/typeController.js
const TypeService = require('../services/typeService');

exports.getAllTypes = async (req, res) => {
  try {
    const filters = {};
    if (req.query.name) {
      filters.name = { contains: req.query.name };
    }
    const types = await TypeService.getAllTypes(filters);
    res.json(types);
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve types' });
  }
};

exports.createType = async (req, res) => {
  try {
    const newType = await TypeService.createType(req.body);
    res.status(201).json(newType);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create type' });
  }
};

exports.getTypeById = async (req, res) => {
  try {
    const type = await TypeService.getTypeById({ id: parseInt(req.params.id) });
    if (type) {
      res.json(type);
    } else {
      res.status(404).json({ error: 'Type not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve type' });
  }
};

exports.updateType = async (req, res) => {
  try {
    const updatedType = await TypeService.updateType({ id: parseInt(req.params.id) }, req.body);
    res.json(updatedType);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update type' });
  }
};

exports.deleteType = async (req, res) => {
  try {
    await TypeService.deleteType({ id: parseInt(req.params.id) });
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete type' });
  }
};