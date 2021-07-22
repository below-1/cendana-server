const faker = require('faker');
const { PrismaClient, Role } = require('@prisma/client');
const prisma = new PrismaClient();

async function seed() {
  const N_USERS = 100;
  let users = [];
  for (let i = 0; i < N_USERS; i++) {
    users.push({
      role: Role.CUSTOMER,
      name: faker.name.firstName()
    })
  }
  await prisma.user.createMany({ data: users });
  await prisma.$disconnect();
}

module.exports = {
  seed
}
