import { prisma } from '@cend/commons/prisma';
import * as DTO from '../product.dto';

export async function create(payload: DTO.Create.Marker) {
  const { categories, ...rest } = payload;
  const product = await prisma.product.create({
    data: {
      ...rest,
      categories: {
        connect: categories
      }
    }
  })
  return product;
}
