import { prisma } from '@cend/commons/prisma';
import {
  OrderStatus, 
  OrderType, 
  DelayType,
  TransactionStatus, 
  TransactionType, 
  PaymentMethod 
} from '@prisma/client';
import { Decimal } from '@prisma/client/runtime';

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
      { orderType: OrderType.SALE }
    ]},
    include: {
      orderItems: true
    }
  });
  if (!order) {
    throw new Error(`can't find sale with id=${orderId}`);
  }
  const { orderItems } = order;

  let statements = [];

  for (let orderItem of orderItems) {
    const { 
      quantity: requestedQuantity,
      productId
    } = orderItem
    let remainder = requestedQuantity
    let lastCreatedAt = null
    let visited: number[] = []
    while (remainder > 0) {
      const stockItem = await prisma.stockItem.findFirst({
        where: {
          id: {
            notIn: visited
          },
          order: {
            orderStatus: OrderStatus.SEALED
          },
          productId
        },
        orderBy: {
          createdAt: 'desc'
        }
      })
      if (!stockItem) {
        throw new Error(`There is no Stock for Product(id=${productId})`)
      }
      console.log(`stock.id = ${stockItem.id}`)
      const {
        available,
        sold
      } = stockItem
      let newAvailable = available
      let newSold = sold
      if (remainder > available) {
        remainder -= available
        newAvailable = 0
        newSold += available
      } else {
        newSold += remainder
        newAvailable = available - remainder
        remainder = 0
      }
      console.log(`remainder = ${remainder}`)
      console.log(`newAvailable = ${newAvailable}`)
      console.log(`newSold = ${newSold}`)
      const syncStockItem = prisma.$executeRaw`
      update "StockItem" 
        set available = ${newAvailable},
        sold = ${newSold}
        where id = ${stockItem.id}`
      visited.push(stockItem.id)
      statements.push(syncStockItem)
    }
    const syncProduct = prisma.$executeRaw`
      update "Product" set 
        available = available - ${orderItem.quantity},
        sold = sold + ${orderItem.quantity}
        where id = ${orderItem.productId}`;
    statements.push(syncProduct);
  }

  const sealOrderStatement = prisma.order.update({
    where: {
      id: orderId
    },
    data: {
      orderStatus: OrderStatus.SEALED
    }
  });
  statements.push(sealOrderStatement);

  const createTransStatement = prisma.transaction.create({
    data: {
      orderId,
      authorId: payload.authorId,
      type: TransactionType.DEBIT,
      status: payload.status,
      paymentMethod: payload.paymentMethod,
      nominal: payload.nominal
    }
  });
  statements.push(createTransStatement);

  const decimalNominal = new Decimal(payload.nominal);

  if (decimalNominal.lessThan(order.grandTotal)) {
    if (!payload.delay) {
      throw new Error(`Due Date of payment is not provided`);
    }
    const createDelayStatement = prisma.delay.create({
      data: {
        authorId: payload.authorId,
        type: DelayType.RECEIVABLE,
        orderId,
        dueDate: new Date(payload.delay.dueDate),
        total: order.grandTotal.sub(decimalNominal).toString(),
        complete: false
      }
    });
    statements.push(createDelayStatement);
  }

  await prisma.$transaction(statements);

  return order;
}