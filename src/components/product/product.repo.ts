import { prisma } from '@cend/commons/prisma';
import * as DTO from './product.dto';

export async function create(payload: DTO.Create.Marker) {
  const product = await prisma.product.create({
    data: payload
  })
  return product;
}

export async function update(id: number, payload: DTO.Update.Marker) {
  const result = await prisma.product.update({
    where: { id },
    data: payload
  });
  return result;
}

export async function remove(id: number) {
  const result = await prisma.product.delete({
    where: { id }
  });
  return result;
}
