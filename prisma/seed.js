const faker = require('faker');
const { PrismaClient, Role } = require('@prisma/client');
const prisma = new PrismaClient();

async function seed() {
  const N_ADMINS = 5;
  const N_SUPPLIERS = 100;
  const N_CUSTOMERS = 100;
  const N_PRODUCT_CATEGORIES = 5;
  const N_PRODUCTS = 50;

  let admins = [];
  let customers = [];
  let suppliers = [];
  let pcats = [];
  let products = [];

  for (let i = 0; i < N_ADMINS; i++) {
    admins.push({
      role: Role.ADMIN,
      password: 'adminzero',
      username: faker.internet.userName(),
      name: faker.name.firstName()
    });
  }
  
  for (let i = 0; i < N_CUSTOMERS; i++) {
    customers.push({
      role: Role.CUSTOMER,
      name: faker.name.firstName()
    });
  }
  
  for (let i = 0; i < N_SUPPLIERS; i++) {
    suppliers.push({
      role: Role.SUPPLIER,
      name: faker.company.companyName(),
      address: faker.address.streetAddress()
    });
  }

  for (let i = 0; i < N_PRODUCT_CATEGORIES; i++) {
    pcats.push({
      title: faker.random.word()
    });
  }

  await prisma.$queryRaw('DELETE FROM "User" WHERE TRUE');
  await prisma.user.createMany({ data: admins });
  await prisma.user.createMany({ data: customers });
  await prisma.user.createMany({ data: suppliers });

  await prisma.$queryRaw('DELETE FROM "ProductCategory" WHERE TRUE');
  await prisma.productCategory.createMany({ data: pcats });

  await prisma.$queryRaw('DELETE FROM "Product" WHERE TRUE');
  for (let i = 0; i < N_PRODUCTS; i++) {
    await prisma.product.create({
      data: {
        name: faker.random.word(),
        unit: 'pcs'
      }
    });
  }

  await prisma.$disconnect();
}

seed()
  .then(() => {
    console.log(`done seeding`);
  })
  .catch(err => {
    console.log(err);
    process.exit(1);
  })

