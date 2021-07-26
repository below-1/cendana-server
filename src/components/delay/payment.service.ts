import { 
  TransactionType,
  TransactionStatus,
  PaymentMethod
} from '@prisma/client';
import { Decimal } from '@prisma/client/runtime';
import { repo as transactionRepo } from '../trans';
import * as paymentViews from './payment.view';
import * as delayViews from './delay.view';
import * as delayServices from './delay.service';

export type AddPaymentPayload = {
  authorId: number;
  delayId: number;
  nominal: string,
  createdAt: string;
  status: TransactionStatus;
  paymentMethod: PaymentMethod;
};

export async function add(payload: AddPaymentPayload) {
  const delay = await delayViews.findOne(payload.delayId);

  if (!delay) {
    throw new Error(`Can't find Delay(id=${payload.delayId})`);
  }
  if (delay.complete) {
    throw new Error(`Delay(id=${payload.delayId}) already complete`);
  }

  const previousPayments = await paymentViews.findForDelay(delay.id);
  const currentPaid = previousPayments
    .map(pay => pay.nominal)
    .reduce((a, b) => a.plus(b), new Decimal('0'));

  const paymentNominal = new Decimal(payload.nominal);
  const nextTotal = paymentNominal.plus(currentPaid);

  if (nextTotal.gt(delay.total)) {
    throw new Error(`Payment is greater than required`);
  }

  const transaction = await transactionRepo.create({
    ...payload,
    type: TransactionType.CREDIT
  });

  await delayServices.updateStatus(delay.id);
  return transaction;
}
