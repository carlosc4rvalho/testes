// src/services/typeService.js
const TypeModel = require('../models/typeModel');

const getAllTypes = async (filters) => {
  return await TypeModel.findMany({ where: filters });
};

const createType = async (data) => {
  return await TypeModel.create(data);
};

const getTypeById = async (where) => {
  return await TypeModel.findUnique(where);
};

const updateType = async (where, data) => {
  return await TypeModel.update(where, data);
};

const deleteType = async (where) => {
  return await TypeModel.delete(where);
};

module.exports = {
  getAllTypes,
  createType,
  getTypeById,
  updateType,
  deleteType
};
