import { prisma } from '@cend/commons/prisma';
import {
  Order,
  StockItem
} from '@prisma/client';
import { findById } from './find-by-id.service';
import { services as orderItemServices } from '@cend/components/oitem';
import { calculateTotal } from './calculate-total.service';

export async function updateStock(id: number) {
  const purchase = await findById(id);
  const orderItemsResult = await orderItemServices.findForSale(id, { perPage: -1, page: 0 })
  console.log(orderItemsResult.items)
  const totals = calculateTotal(purchase, orderItemsResult.items);
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
