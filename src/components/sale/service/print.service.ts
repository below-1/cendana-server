import { prisma } from '@cend/commons/prisma';
import { OrderType } from '@prisma/client';
import { FindOptions } from '@cend/commons/find';
import { print } from '@cend/components/printer';
import { toDateUpperLower } from '@cend/commons/to-date-upper-lower'

type Conditions = {
  year: number;
  month: number;
}

export async function printSales(options: Conditions) {
  const { month, year } = options;
  const { lower: lowerDate, upper: upperDate } = toDateUpperLower(year, month)
  const sales = await prisma.order.findMany({
    where: {
      AND: [
        { orderType: OrderType.SALE },
        { createdAt: {
          gte: lowerDate,
          lte: upperDate
        }}
      ],
    },
    orderBy: {
      createdAt: 'desc'
    },
    include: {
      transaction: true,
      targetUser: true,
      orderItems: {
        include: {
          product: true
        }
      }
    }
  });
  
  let items: any[] = [];
  let lastTanggal: Date | null = null;
  let lastKode: string | null = null;
  let lastCustomerName: string | null = null;
  for (let sale of sales) {
    let oiIndex = 0;
    let saleKode = sale.id;
    let tanggal: any;
    if (lastTanggal != sale.createdAt) {
      lastTanggal = sale.createdAt;
      tanggal = lastTanggal.toISOString();
    } else {
      tanggal = '';
    }
    for (let oi of sale.orderItems) {
      let item: any = {};
      item.itemName = oi.product.name;
      item.itemQuantity = oi.quantity;
      item.itemSellPrice = oi.sellPrice.toFixed(2);
      item.item_harga_x_qty = oi.sellPrice.mul( oi.quantity ).toFixed(2);
      if (oiIndex == 0) {
        item.tanggal = tanggal;
        item.kode = sale.id;
        item.customerName = sale.targetUser.name;
        item.customerAddress = sale.targetUser.address;
      }
      items.push(item);
      oiIndex += 1;
    }
  }
  // console.log(items);
  // throw new Error('stop');
  const buffer = await print({ data: { items },  path: 'sales.xlsx' });
  return buffer;
}