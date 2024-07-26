// src/models/typeModel.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const findMany = (filter) => prisma.type.findMany(filter);
const create = (data) => prisma.type.create({ data });
const findUnique = (where) => prisma.type.findUnique({ where });
const update = (where, data) => prisma.type.update({ where, data });
const deleteType = (where) => prisma.type.delete({ where });

module.exports = {
  findMany,
  create,
  findUnique,
  update,
  delete: deleteType
};
