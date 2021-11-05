import { prisma } from '@cend/commons/prisma'
import { TransactionType } from '@prisma/client'
import * as DTO from '../investment-trans.dto'

export async function create(payload: DTO.Create.Marker) {
  const trans = await prisma.transaction.create({
    data: {
      type: TransactionType.CREDIT,
      ...payload
    }
  })
  return trans
}
