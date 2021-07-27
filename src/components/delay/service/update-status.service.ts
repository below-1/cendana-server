import { prisma } from '@cend/commons/prisma';
import { Decimal } from '@prisma/client/runtime';
import { getCurrentPaid }  from './get-current-paid.service';

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