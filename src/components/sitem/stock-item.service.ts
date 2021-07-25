import { prisma } from '@cend/commons/prisma';
import { OrderStatus } from '@prisma/client';
import * as DTO from './stock-item.dto';
import { updateStock } from '../purchase/purchase.service';
import { findPurchaseById } from '../purchase/purchase.view';
import * as stockItemViews from './stock-item.view';

export async function create(payload: DTO.Create.Marker) {
  const { orderId } = payload;
  const purchase = await findPurchaseById(orderId);
  if (!purchase) {
    throw new Error(`Purchase(id=${orderId}) can't be found`);
  }
  if (purchase.orderStatus != OrderStatus.OPEN) {
    throw new Error(`Purchase(id=${orderId}) is not OPEN`);
  }
  const stockItem = await prisma.stockItem.create({
    data: payload
  });
  await updateStock(orderId);
  return stockItem;
}

export async function update(id: number, payload: DTO.Update.Marker) {
  const stockItem = await stockItemViews.findById(id);
  if (!stockItem) {
    throw new Error(`StockItem(id=${id}) can't be found`);
  }
  const { orderId } = stockItem;
  const purchase = await findPurchaseById(orderId);
  if (!purchase) {
    throw new Error(`Purchase(id=${orderId}) can't be found`);
  }
  if (purchase.orderStatus != OrderStatus.OPEN) {
    throw new Error(`Purchase(id=${orderId}) is not OPEN`);
  }
  const result = await prisma.stockItem.update({
    where: { id },
    data: payload
  });
  await updateStock(orderId);
  return result;
}

export async function remove(id: number) {
  const stockItem = await stockItemViews.findById(id);
  if (!stockItem) {
    throw new Error(`StockItem(id=${id}) can't be found`);
  }
  const { orderId } = stockItem;
  const purchase = await findPurchaseById(orderId);
  if (!purchase) {
    throw new Error(`Purchase(id=${orderId}) can't be found`);
  }
  if (purchase.orderStatus != OrderStatus.OPEN) {
    throw new Error(`Purchase(id=${orderId}) is not OPEN`);
  }
  const result = await prisma.stockItem.delete({
    where: { id }
  });
  await updateStock(orderId);
  return result;
}
