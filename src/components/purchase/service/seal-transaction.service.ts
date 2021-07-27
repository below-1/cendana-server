import { prisma } from '@cend/commons/prisma';
import {
  OrderStatus, 
  OrderType, 
  DelayType,
  TransactionStatus, 
  TransactionType, 
  PaymentMethod 
} from '@prisma/client';
import { services as stockItemServices } from '@cend/components/sitem';
import { services as delayServices } from '@cend/components/delay';
import * as productServices from '../../product/product.service';
import { services as transactionServices } from '../../trans'

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
  const stockItems = await stockItemServices.findForOrder(orderId);
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
  const transaction = await transactionServices.create({
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
    await delayServices.create({
      authorId: payload.authorId,
      type: DelayType.PAYABLE,
      orderId,
      dueDate: new Date(payload.delay.dueDate),
      total: order.grandTotal.sub(transaction.nominal).toString()
    })
  }
  return result;
}