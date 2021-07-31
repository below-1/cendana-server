import { prisma } from '@cend/commons/prisma';
import { OrderStatus, OrderType } from '@prisma/client';
import { Decimal } from '@prisma/client/runtime';
import { services as stockItemServices } from '@cend/components/sitem';

export type CreatePayload = {
  orderId: number;
  authorId: number;
  productId: number;
  stockItemId: number;
  quantity: number;
  discount: number;
  description?: string;
  sellPrice?: string;
}

export async function create(payload: CreatePayload) {
  const { orderId, productId, authorId, stockItemId, ...rest } = payload;
  const order = await prisma.order.findFirst({
    where: {
      id: orderId,
      orderType: OrderType.SALE
    }
  });

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

  const orderItem = prisma.orderItem.create({
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
  return orderItem;
}
