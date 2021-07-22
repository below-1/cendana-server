import { prisma } from '@cend/commons/prisma'
import * as DTO from './product-category.dto'

export async function create(payload: DTO.Create.Marker) {
  const result = await prisma.productCategory.create({
    data: payload
  });
  return result;
}

export async function update(id: number, payload: DTO.Update.Marker) {
  const result = await prisma.productCategory.update({
    where: { id },
    data: payload
  });
  return result;
}

export async function remove(id: number) {
  const result = await prisma.productCategory.delete({
    where: { id }
  });
  return result;
}
