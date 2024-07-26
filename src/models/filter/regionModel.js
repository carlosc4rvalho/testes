// src/models/regionModel.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const findMany = (filter) => prisma.region.findMany(filter);
const create = (data) => prisma.region.create({ data });
const findUnique = (where) => prisma.region.findUnique({ where });
const update = (where, data) => prisma.region.update({ where, data });
const deleteRegion = (where) => prisma.region.delete({ where });

module.exports = {
  findMany,
  create,
  findUnique,
  update,
  delete: deleteRegion
};
