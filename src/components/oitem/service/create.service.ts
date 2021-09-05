import { prisma } from '@cend/commons/prisma';
import { OrderStatus, OrderType } from '@prisma/client';
import { Decimal } from '@prisma/client/runtime';
import { services as stockItemServices } from '@cend/components/sitem';
import { services as saleServices } from '@cend/components/sale'
import { services as productServices } from '@cend/components/product'

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
  const { orderId, productId, authorId, ...rest } = payload
  const product = await productServices.findOne(productId)
  if (!product) {
    throw new Error(`Product(id=${productId}) not found`)
  }
  prisma.product.update({
    where: {
      id: productId
    },
    data: {
      available: product.available - payload.quantity,
      sold: product.sold + payload.quantity
    }
  })
  
  
  const order = await saleServices.findById(orderId)

  if (!order) {
    throw new Error(`Sale(id=${orderId}) can't be found`);
  }
  if (order.orderStatus != OrderStatus.OPEN) {
    throw new Error(`Sale(id=${orderId}) is not OPEN`);
  }

  const { buyPrice } = product;
  let sellPrice: string | Decimal = product.sellPrice;
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
      product: {
        connect: { id: productId }
      }
    }
  });
  
  await saleServices.updateStock(orderId)

  return orderItem;
}
