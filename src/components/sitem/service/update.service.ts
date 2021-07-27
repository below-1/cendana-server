import { prisma } from '@cend/commons/prisma';
import { OrderStatus } from '@prisma/client';
import * as DTO from '../stock-item.dto';
import { findById } from './find-by-id.service';
import { 
  findById as findPurchaseById,
  updateStock
} from '@cend/components/purchase/service';

export async function update(id: number, payload: DTO.Update.Marker) {
  const stockItem = await findById(id);
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