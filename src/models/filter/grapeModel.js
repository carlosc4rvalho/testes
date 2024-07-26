// src/models/grapeModel.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const findMany = (filter) => prisma.grape.findMany(filter);
const create = (data) => prisma.grape.create({ data });
const findUnique = (where) => prisma.grape.findUnique({ where });
const update = (where, data) => prisma.grape.update({ where, data });
const deleteGrape = (where) => prisma.grape.delete({ where });

module.exports = {
  findMany,
  create,
  findUnique,
  update,
  delete: deleteGrape
};
