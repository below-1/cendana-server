import { prisma } from '@cend/commons/prisma'

export async function hpp(date: String) {
  const [ { total: result } ] = await prisma.$queryRaw(`
    select sum(rp.available * rp."sellPrice") total from "RecordProduct" rp where rp."date" = '${date}'`)
  return result
}