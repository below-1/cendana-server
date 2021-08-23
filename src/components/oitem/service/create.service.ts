import { prisma } from '@cend/commons/prisma';
import { OrderStatus, OrderType } from '@prisma/client';
import { Decimal } from '@prisma/client/runtime';
import { services as stockItemServices } from '@cend/components/sitem';
import { services as saleServices } from '@cend/components/sale'

export type CreatePayload = {
  orderId: number;
  authorId: number;
  productId: number;
  quantity: number;
  discount: number;
  description?: string;
  sellPrice?: string;
}

export async function create(payload: CreatePayload) {
  const { orderId, productId, authorId, ...rest } = payload;

  let remainder = rest.quantity;
  let visited: number[] = [];
  let lastVisitedStockItem = null
  while (remainder > 0) {
    const stockItem = await prisma.stockItem.findFirst({
      where: {
        AND: [
          { productId },
          {
            order: { orderStatus: OrderStatus.SEALED }
          },
          { id: { notIn: visited } }
        ]
      },
      orderBy: {
        createdAt: 'desc'
      }
    })
    if (!stockItem) {
      throw new Error('stockItem not found');
    }
    const { available } = stockItem
    let newAvailable = 0
    if (remainder >= available) {
      newAvailable = remainder - available
      remainder = newAvailable
    } else {
      newAvailable = available - remainder
      remainder = 0
    }
    lastVisitedStockItem = stockItem
  }
  if(!lastVisitedStockItem) {
    throw new Error(`timestamped stockItem is undefined`)
  }
  const { id: stockItemId } = lastVisitedStockItem

  const order = await saleServices.findById(orderId)

  if (!order) {
    throw new Error(`Sale(id=${orderId}) can't be found`);
  }
  if (order.orderStatus != OrderStatus.OPEN) {
    throw new Error(`Sale(id=${orderId}) is not OPEN`);
  }

  const stockItem = await stockItemServices.findById(stockItemId);
  if (!stockItem) {
    throw new Error(`StockItem(id=${stockItemId}) can't be found`);
  }
  const { buyPrice } = stockItem;
  let sellPrice: string | Decimal = stockItem.sellPrice;
  if (rest.sellPrice) {
    sellPrice = rest.sellPrice;
  }

  const orderItem = await prisma.orderItem.create({
    data: {
      ...rest,
      buyPrice,
      sellPrice,
      author: {
        connect: { id: authorId }
      },
      order: {
        connect: { id: orderId }
      },
      stockItem: {
        connect: { id: stockItemId }
      },
      product: {
        connect: { id: productId }
      }
    }
  });
  
  await saleServices.updateStock(orderId)

  return orderItem;
}
