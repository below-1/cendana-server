import { FindOptions } from '@cend/commons/find';
import { prisma } from '@cend/commons/prisma';

export async function find(keyword: string, options: FindOptions.Marker) {
  const where = {
    title: {
      contains: keyword
    }
  }
  const totalData = await prisma.opexCategory.count({ where });
  const totalPage = Math.ceil(totalData / options.perPage);
  const items = await prisma.opexCategory.findMany({ where });
  return {
    totalData,
    totalPage,
    items
  };
}

export async function findOne(id: number) {
  const opexCategory = await prisma.opexCategory.findFirst({
    where: {
      id
    }
  });
  return opexCategory;
}