import { prisma } from '@cend/commons/prisma';
import { OrderType } from '@prisma/client';
import { FindOptions } from '@cend/commons/find';
import { toDateUpperLower } from '@cend/commons/to-date-upper-lower'
import { format } from 'date-fns';
import * as csv from 'fast-csv';

export async function printProducts() {
  const items = await prisma.product.findMany({
    orderBy: {
      name: 'asc'
    }
  });
  const csvStream = csv.format({ headers: true });
  items.forEach(item => {
    let product = {
      tanggal: format(item.createdAt, 'yyyy-MM-dd'),
      nama: item.name,
      'harga beli': item.buyPrice,
      'harga jual': item.sellPrice,
      tersedia: item.available,
      terjual: item.sold,
      unit: item.unit
    }
    csvStream.write(product);
  });
  csvStream.end();
  return csvStream;
}