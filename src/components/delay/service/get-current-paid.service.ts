import { prisma } from '@cend/commons/prisma';
import { Decimal } from '@prisma/client/runtime';
import { findPayments } from './find-payments.service';

export async function getCurrentPaid(id: number) {
  const payments = await findPayments(id);
  const currentPaid = payments
    .map(pay => pay.nominal)
    .reduce((a, b) => a.plus(b), new Decimal('0'));
  return currentPaid;
}
