import { prisma } from '@cend/commons/prisma';
import * as DTO from '../tool.dto';

export async function create(payload: DTO.Create.Marker) {
  const tool = await prisma.tool.create({
    data: payload
  })
  return tool
}