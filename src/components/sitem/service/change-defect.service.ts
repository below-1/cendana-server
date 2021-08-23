import { prisma } from '@cend/commons/prisma'
import { services as productServices } from '@cend/components/product'

export async function changeDefect(stockItemId: number, defect: number) {
  let stockItem = await prisma.stockItem.findFirst({ 
    where: { 
      id: stockItemId 
    } 
  })
  if (!stockItem) {
    throw new Error(`StockItem(id=${stockItemId}) can't be found`)
  }
  let {
    productId,
    available,
    defect: oldDefect
  } = stockItem

  if (defect > available) {
    throw new Error(`defect can't be greater than available`);
  }
  if (defect < 0) {
    throw new Error(`defect must be positive`);
  }

  const diff = defect - oldDefect
  available = available - diff

  const result = await prisma.stockItem.update({
    where: {
      id: stockItemId
    },
    data: {
      available,
      defect
    }
  })

  await productServices.updateStocks(productId)


  return result
}