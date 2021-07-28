import { 
  TransactionType,
  TransactionStatus,
  PaymentMethod
} from '@prisma/client';
import { Decimal } from '@prisma/client/runtime';
import { services as transactionServices } from '@cend/components/trans';
import { findOne } from './find-one.service';
import { findPayments } from './find-payments.service';
import { updateStatus } from './update-status.service';

export type AddPaymentPayload = {
  authorId: number;
  delayId: number;
  nominal: string,
  createdAt: string;
  status: TransactionStatus;
  paymentMethod: PaymentMethod;
};

export async function add(payload: AddPaymentPayload) {
  const delay = await findOne(payload.delayId);

  if (!delay) {
    throw new Error(`Can't find Delay(id=${payload.delayId})`);
  }
  if (delay.complete) {
    throw new Error(`Delay(id=${payload.delayId}) already complete`);
  }

  const previousPayments = await findPayments(delay.id);
  const currentPaid = previousPayments
    .map(pay => pay.nominal)
    .reduce((a, b) => a.plus(b), new Decimal('0'));

  const paymentNominal = new Decimal(payload.nominal);
  const nextTotal = paymentNominal.plus(currentPaid);

  if (nextTotal.gt(delay.total)) {
    throw new Error(`Payment is greater than required`);
  }

  const transaction = await transactionServices.create({
    ...payload,
    type: TransactionType.CREDIT
  });

  await updateStatus(delay.id);
  return transaction;
}