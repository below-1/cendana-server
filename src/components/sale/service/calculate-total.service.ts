import { Decimal } from '@prisma/client/runtime';
import {
  Order,
  OrderItem
} from '@prisma/client';

export function calculateTotal(order: Order, orderItems: OrderItem[]) {
  // SUB_TOTAL
  const subTotal = orderItems
    .map(x => x.sellPrice.mul(x.quantity))
    .reduce((a, b) => a.plus(b), new Decimal('0'));

    // TOTAL
  const tax = new Decimal(order.tax / 100);
  const totalPlusShipping = subTotal.plus(order.shipping);
  const totalPlusShippingAndTax = totalPlusShipping.plus(totalPlusShipping.mul(tax));
  const total = totalPlusShippingAndTax;
  
  // GRAND TOTAL
  const itemsDiscountedTotal = orderItems
    .map(si => {
      const discount = new Decimal(si.discount).div(100)
      const totalItemPrice = si.sellPrice.mul(si.quantity)
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
