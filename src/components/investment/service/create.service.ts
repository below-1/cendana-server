import { prisma } from '@cend/commons/prisma';
import * as DTO from '../investment.dto';

export async function create(payload: DTO.Create.Marker) {
  const result = await prisma.investment.create({
    data: payload
  })
  return result
}