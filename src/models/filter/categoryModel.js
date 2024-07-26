// src/models/categoryModel.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const findMany = (filter) => prisma.category.findMany(filter);
const create = (data) => prisma.category.create({ data });
const findUnique = (where) => prisma.category.findUnique({ where });
const update = (where, data) => prisma.category.update({ where, data });
const deleteCategory = (where) => prisma.category.delete({ where });

module.exports = {
  findMany,
  create,
  findUnique,
  update,
  delete: deleteCategory
};
