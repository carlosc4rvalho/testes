// src/controllers/countryController.js
const CountryService = require('../services/countryService');

exports.getAllCategories = async (req, res) => {
  try {
    const filters = {};
    if (req.query.name) {
      filters.name = { contains: req.query.name };
    }
    const categories = await CountryService.getAllCategories(filters);
    res.json(categories);
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve categories' });
  }
};

exports.createCountry = async (req, res) => {
  try {
    const newCountry = await CountryService.createCountry(req.body);
    res.status(201).json(newCountry);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create country' });
  }
};

exports.getCountryById = async (req, res) => {
  try {
    const country = await CountryService.getCountryById({ id: parseInt(req.params.id) });
    if (country) {
      res.json(country);
    } else {
      res.status(404).json({ error: 'Country not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve country' });
  }
};

exports.updateCountry = async (req, res) => {
  try {
    const updatedCountry = await CountryService.updateCountry({ id: parseInt(req.params.id) }, req.body);
    res.json(updatedCountry);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update country' });
  }
};

exports.deleteCountry = async (req, res) => {
  try {
    await CountryService.deleteCountry({ id: parseInt(req.params.id) });
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete country' });
  }
};