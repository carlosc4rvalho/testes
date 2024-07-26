// src/models/pairingModel.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const findMany = (filter) => prisma.pairing.findMany(filter);
const create = (data) => prisma.pairing.create({ data });
const findUnique = (where) => prisma.pairing.findUnique({ where });
const update = (where, data) => prisma.pairing.update({ where, data });
const deletePairing = (where) => prisma.pairing.delete({ where });

module.exports = {
  findMany,
  create,
  findUnique,
  update,
  delete: deletePairing
};
