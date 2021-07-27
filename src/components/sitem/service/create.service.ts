import { prisma } from '@cend/commons/prisma';
import { OrderStatus } from '@prisma/client';
import * as DTO from '../stock-item.dto';
import { 
  findById as findPurchaseById,
  updateStock
} from '@cend/components/purchase/service';

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
