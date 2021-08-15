import fastify from 'fastify'
import blipp from 'fastify-blipp'
import cors from 'fastify-cors'
import swagger from 'fastify-swagger'

import * as components from '@cend/components'

export function createServer() {
  const server = fastify({
    // logger: process.env.NODE_ENV == 'development',
    logger: true
  })
  server.register(cors)
  server.register(blipp)
  server.register(swagger, {
    routePrefix: '/documentation',
    exposeRoute: true,
    swagger: {
      info: {
        title: 'Cendana API',
        version: '1.0.0'
      },
      tags: [
        { name: 'product-categories', description: "Product Categories' Product Endpoints" },
        { name: 'products', description: "Product's Endpoints" }
      ]
    }
  } as any)

  // server.register(prisma)
  server.register(components.auth.plugin, { prefix: '/auth' })
  server.register(components.productCategory.plugin, { prefix: '/v1/api/product-categories' })
  server.register(components.product.plugin, { prefix: '/v1/api/products' })
  server.register(components.user.plugin, { prefix: '/v1/api/users' })
  server.register(components.purchase.plugin, { prefix: '/v1/api/purchases' })
  server.register(components.stockItem.plugin, { prefix: '/v1/api/stock-items' })
  server.register(components.sale.plugin, { prefix: '/v1/api/sales' })
  server.register(components.orderItem.plugin, { prefix: '/v1/api/order-items' })
  server.register(components.delay.plugin, { prefix: '/v1/api/delays' })
  server.register(components.opex.plugin, { prefix: '/v1/api/opexes' })
  server.register(components.opexTrans.plugin, { prefix: '/v1/api/opex-trans' })
  server.register(components.tool.plugin, { prefix: '/v1/api/tools' })
  server.register(components.toolTrans.plugin, { prefix: '/v1/api/tool-trans' })
  server.register(components.transaction.plugin, { prefix: '/v1/api/transactions' })
  server.register(components.latestStock.plugin, { prefix: '/v1/api/latest-stock' })

  return server
}
