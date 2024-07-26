// src/models/countryModel.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const findMany = (filter) => prisma.country.findMany(filter);
const create = (data) => prisma.country.create({ data });
const findUnique = (where) => prisma.country.findUnique({ where });
const update = (where, data) => prisma.country.update({ where, data });
const deleteCountry = (where) => prisma.country.delete({ where });

module.exports = {
  findMany,
  create,
  findUnique,
  update,
  delete: deleteCountry
};
