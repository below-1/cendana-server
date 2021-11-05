import { prisma } from '@cend/commons/prisma'
import { TransactionType } from '@prisma/client'
import * as DTO from '../investment-trans.dto'

export async function update(id: number, payload: DTO.Update.Marker) {
  const trans = await prisma.transaction.update({
    where: { id },
    data: {
      ...payload
    }
  })
  return trans
}
