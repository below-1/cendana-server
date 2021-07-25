import * as DTO from './purchase.dto';
import * as DTOStockItem from '../sitem/stock-item.dto';
import { Order, StockItem, OrderStatus, OrderType } from '@prisma/client';
import { prisma } from '@cend/commons/prisma';
import { Decimal, PrismaClientPromise } from '@prisma/client/runtime';
import { findForOrder } from '../sitem/stock-item.view'
import { findPurchaseById } from './purchase.view'
import * as productViews from '../product/product.view';
import * as productServices from '../product/product.service';

export async function create(payload: DTO.Create.Marker) {
  const { authorId, targetUserId, ...rest } = payload;
  const purchase = await prisma.order.create({
    data: {
      ...rest,
      // Initial value for some fields
      grandTotal: 0,
      subTotal: 0,
      tax: 0,
      shipping: 0,
      discount: 0,
      orderStatus: OrderStatus.OPEN,
      orderType: OrderType.BUY,
      author: {
        connect: { id: authorId }
      },
      targetUser: {
        connect: { id: targetUserId }
      }
    }
  });
  return purchase;
}

export async function updateStock(orderId: number) {
  const purchase = await findPurchaseById(orderId);
  const stockItems = await findForOrder(orderId);
  const totals = calculatePurchaseTotals(purchase, stockItems);
  const result = await prisma.order.update({
    where: {
      id: orderId
    },
    data: {
      grandTotal: totals.grandTotal,
      subTotal: totals.subTotal,
      total: totals.total
    }
  });
  return result;
}

export function calculatePurchaseTotals(order: Order, stockItems: StockItem[]) {
  // SUB_TOTAL
  const subTotal = stockItems
    .map(x => x.buyPrice.mul(x.quantity))
    .reduce((a, b) => a.plus(b), new Decimal('0'));

  const totalPlusShipping = subTotal.plus(order.shipping);
  const totalPlusShippingAndTax = totalPlusShipping.plus(totalPlusShipping.mul(order.tax));

  // TOTAL
  const total = totalPlusShippingAndTax;

  const itemsDiscountedTotal = stockItems
    .map(si => {
      const totalItemPrice = si.buyPrice.mul(si.quantity)
      const discountedTotalItemPrice = totalItemPrice.mul(si.discount)
      const totalMinusDiscount = totalItemPrice.sub(discountedTotalItemPrice)
      return totalMinusDiscount
    })
    .reduce((a, b) => a.plus(b), new Decimal('0'));
  const taxedItemsDiscounted = itemsDiscountedTotal.sub( itemsDiscountedTotal.mul(order.tax) );
  const itemsDiscountedPlusShipping = taxedItemsDiscounted.plus(order.shipping);

  // GRAND TOTAL
  const grandTotal = itemsDiscountedPlusShipping;

  return {
    total,
    subTotal,
    grandTotal
  }
}

export async function getCurrentPurchaseTotals(orderId: number) {
  const order = await prisma.order.findFirst({ where: { id: orderId } });
  if (!order) {
    throw new Error(`can't find order with id=${orderId}`);
  }
  const stockItems = await prisma.order
    .findFirst({ where: { id: orderId } })
    .stockItems();

  const allTotals = calculatePurchaseTotals(order, stockItems);

  return allTotals;
}

export async function sealTransaction(orderId: number) {
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
  const updateResult = await prisma.order.update({
    where: {
      id: orderId
    },
    data: {
      orderStatus: OrderStatus.SEALED
    }
  })
  return updateResult;
}
