import { prisma } from '@cend/commons/prisma';

export async function removePayment(id: number) {
  const payment = await prisma.transaction.findFirst({
    where: {
      id
    }
  })
  if (!payment) {
    throw new Error(`Payment(id=${id}) can't be found`)
  }
  if (!payment.delayId) {
    throw new Error(`Transaction(id=${id}) is not Delay`)
  }

  const { delayId } = payment
  const removeStatement = prisma.transaction.delete({
    where: { id }
  })
  const updateDelayStatement = prisma.delay.update({
    where: { id: delayId },
    data: {
      complete: false
    }
  })

  await prisma.$transaction([
    removeStatement,
    updateDelayStatement
  ])  

  return payment;
}
