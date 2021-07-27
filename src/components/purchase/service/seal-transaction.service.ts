import { prisma } from '@cend/commons/prisma';
import {
  OrderStatus, 
  OrderType, 
  DelayType,
  TransactionStatus, 
  TransactionType, 
  PaymentMethod 
} from '@prisma/client';
import { findForOrder } from '../../sitem/stock-item.view'
import * as productServices from '../../product/product.service';
import { repo as transactionRepo } from '../../trans'
import { delayRepo as delayRepo } from '../../delay'

type DelayData = {
  dueDate: string;
}

export type SealTransactionPayload = {
  orderId: number;
  authorId: number;
  nominal: string;
  status: TransactionStatus;
  paymentMethod: PaymentMethod;
  delay?: DelayData;
}

export async function sealTransaction(payload: SealTransactionPayload) {
  const { orderId } = payload;
  const order = await prisma.order.findFirst({ 
    where: { AND: [
      { id: orderId },
      { orderType: OrderType.BUY }
    ]}
  });
  if (!order) {
    throw new Error(`can't find purchase with id=${orderId}`);
  }
  const stockItems = await findForOrder(orderId);
  for (let stockItem of stockItems) {
    await productServices.updateStocks(stockItem.productId);
  }
  const result = await prisma.order.update({
    where: {
      id: orderId
    },
    data: {
      orderStatus: OrderStatus.SEALED
    }
  })
  const transaction = await transactionRepo.create({
    orderId: result.id,
    authorId: payload.authorId,
    type: TransactionType.CREDIT,
    status: payload.status,
    paymentMethod: payload.paymentMethod,
    nominal: payload.nominal
  })
  if (transaction.nominal.lessThan(order.grandTotal)) {
    if (!payload.delay) {
      throw new Error(`Due Date of payment is not provided`);
    }
    await delayRepo.create({
      authorId: payload.authorId,
      type: DelayType.PAYABLE,
      orderId,
      dueDate: new Date(payload.delay.dueDate),
      total: order.grandTotal.sub(transaction.nominal).toString()
    })
  }
  return result;
}