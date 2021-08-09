import { Decimal } from '@prisma/client/runtime';
import {
  Order,
  StockItem
} from '@prisma/client';

export function calculateTotal(order: Order, stockItems: StockItem[]) {
  // SUB_TOTAL
  const subTotal = stockItems
    .map(x => x.buyPrice.mul(x.quantity))
    .reduce((a, b) => a.plus(b), new Decimal('0'));

    // TOTAL
  const tax = new Decimal(order.tax / 100);
  const totalPlusShipping = subTotal.plus(order.shipping);
  const totalPlusShippingAndTax = totalPlusShipping.plus(totalPlusShipping.mul(tax));
  const total = totalPlusShippingAndTax;
  
  // GRAND TOTAL
  const itemsDiscountedTotal = stockItems
    .map(si => {
      const discount = new Decimal(si.discount).div(100)
      const totalItemPrice = si.buyPrice.mul(si.quantity)
      const discountedTotalItemPrice = totalItemPrice.mul(discount)
      const totalMinusDiscount = totalItemPrice.sub(discountedTotalItemPrice)
      return totalMinusDiscount
    })
    .reduce((a, b) => a.plus(b), new Decimal('0'));
  const taxedItemsDiscounted = itemsDiscountedTotal.plus( itemsDiscountedTotal.mul(tax))
  const itemsDiscountedPlusShipping = taxedItemsDiscounted.plus(order.shipping)
  const grandTotal = itemsDiscountedPlusShipping;

  return {
    total,
    subTotal,
    grandTotal
  }
}
