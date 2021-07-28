import { prisma } from '@cend/commons/prisma';
import {
  Order,
  StockItem
} from '@prisma/client';
import { findById } from './find-by-id';
import { calculateTotal } from './calculate-total.service';
import { services as stockItemServices } from '@cend/components/sitem';

export async function updateStock(id: number) {
  const purchase = await findById(id);
  const stockItems = await stockItemServices.findForOrder(id);
  const totals = await calculateTotal(purchase, stockItems);
  const result = await prisma.order.update({
    where: {
      id
    },
    data: {
      grandTotal: totals.grandTotal,
      subTotal: totals.subTotal,
      total: totals.total
    }
  });
  return result;
}