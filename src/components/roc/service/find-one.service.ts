import createError from 'fastify-error'
import { prisma } from '@cend/commons/prisma'
import { OrderType } from '@prisma/client'
import { ROCNotFound } from './errors'

export async function findOne(id: number) {
  const transaction = await prisma.transaction.findFirst({
    where: {
      AND: [
        { id },
        { pengembalianModalFlag: { gt: 0 } }
      ]
    },
    include: {
      author: true
    }
  })
  if (!transaction) {
    throw new ROCNotFound(id)
  }
  return transaction
}
