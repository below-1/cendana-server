import { prisma } from '@cend/commons/prisma';
import * as DTO from '../delay.dto';

export async function find(options: DTO.Find.Marker) {
  let conditions = []
  if (options.type) {
    conditions.push({ type: options.type })
  }
  if (options.complete) {
    conditions.push({ complete: options.complete })
  }
  const where = { where: {AND: conditions} }
  const totalData = await prisma.delay.count({ ...where })
  let totalPage = totalData;
  if (options.perPage != -1) {
    totalPage = Math.ceil(totalData / options.perPage);
  }
  const offset = options.perPage * options.page;
  const items = await prisma.delay.findMany({ 
    ...where,
    skip: offset,
    take: options.perPage
  })
  return {
    totalPage,
    totalData,
    items
  }
}