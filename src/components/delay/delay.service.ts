import { prisma } from '@cend/commons/prisma';
import { Decimal } from '@prisma/client/runtime';
import * as paymentViews from './payment.view';

export async function getCurrentPaid(id: number) {
  const payments = await paymentViews.findForDelay(id);
  const currentPaid = payments
    .map(pay => pay.nominal)
    .reduce((a, b) => a.plus(b), new Decimal('0'));
  return currentPaid;
}

export async function updateStatus(id: number) {
  const delay = await prisma.delay.findFirst({
    where: { id },
    include: {
      transactions: true
    }
  })

  if (!delay) {
    throw new Error(`Delay(id=${id}) can't be found`);
  }

  const currentPaid = await getCurrentPaid(id);
  let complete = false;
  if (currentPaid.eq(delay.total)) {
    complete = true;
  }

  await prisma.delay.update({
    where: { id },
    data: { complete }
  })
}
