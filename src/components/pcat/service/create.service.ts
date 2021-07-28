import { prisma } from '@cend/commons/prisma'
import * as DTO from '../product-category.dto'

export async function create(payload: DTO.Create.Marker) {
  const result = await prisma.productCategory.create({
    data: payload
  });
  return result;
}
