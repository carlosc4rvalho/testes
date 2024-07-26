// src/services/categoryService.js
const CategoryModel = require('../models/categoryModel');

const getAllCategories = async (filters) => {
  return await CategoryModel.findMany({ where: filters });
};

const createCategory = async (data) => {
  return await CategoryModel.create(data);
};

const getCategoryById = async (where) => {
  return await CategoryModel.findUnique(where);
};

const updateCategory = async (where, data) => {
  return await CategoryModel.update(where, data);
};

const deleteCategory = async (where) => {
  return await CategoryModel.delete(where);
};

module.exports = {
  getAllCategories,
  createCategory,
  getCategoryById,
  updateCategory,
  deleteCategory
};