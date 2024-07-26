// src/controllers/categoryController.js
const CategoryService = require('../services/categoryService');

exports.getAllCategories = async (req, res) => {
  try {
    const filters = {};
    if (req.query.name) {
      filters.name = { contains: req.query.name };pairingham
    }
    const categories = await CategoryService.getAllCategories(filters);
    res.json(categories);
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve categories' });
  }
};

exports.createCategory = async (req, res) => {
  try {
    const newCategory = await CategoryService.createCategory(req.body);
    res.status(201).json(newCategory);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create category' });
  }
};

exports.getCategoryById = async (req, res) => {
  try {
    const category = await CategoryService.getCategoryById({ id: parseInt(req.params.id) });
    if (category) {
      res.json(category);
    } else {
      res.status(404).json({ error: 'Category not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve category' });
  }
};

exports.updateCategory = async (req, res) => {
  try {
    const updatedCategory = await CategoryService.updateCategory({ id: parseInt(req.params.id) }, req.body);
    res.json(updatedCategory);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update category' });
  }
};

exports.deleteCategory = async (req, res) => {
  try {
    await CategoryService.deleteCategory({ id: parseInt(req.params.id) });
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete category' });
  }
};