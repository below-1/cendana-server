import { FastifyInstance } from "fastify";
import { FindOptions } from '@cend/commons/find'
import { ID }  from '@cend/commons/request';
import * as handler from './product.handler';
import * as DTO from './product.dto';

export async function plugin(fastify: FastifyInstance) {

  fastify.post('/', {
    schema: {
      tags: ['products'],
      body: DTO.Create.Obj,
      response: {
        200: ID.Obj
      }
    },
    handler: handler.post
  })

  fastify.put('/:id', {
    schema: {
      tags: ['products'],
      body: DTO.Update.Obj,
      params: ID.Obj
    },
    handler: handler.put
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['products'],
      params: ID.Obj
    },
    handler: handler.remove
  })

  fastify.get('/:id', {
    schema: {
      tags: ['products'],
      params: ID.Obj
    },
    handler: handler.getById
  })

  fastify.get('/', {
    schema: {
      tags: ['products'],
      querystring: DTO.Find.Obj
    },
    handler: handler.get
  })

  fastify.get('/free-for-order', {
    schema: {
      tags: ['products'],
      querystring: DTO.FindFreeForOrder.Obj
    },
    handler: handler.getFreeForOrder
  })

  fastify.get('/:id/sales', {
    schema: {
      tags: ['products', 'sales'],
      params: ID.Obj,
      querystring: FindOptions.Obj
    },
    handler: handler.getProductSales
  })

  fastify.get('/:id/purchases', {
    schema: {
      tags: ['products'],
      params: ID.Obj,
      querystring: FindOptions.Obj
    },
    handler: handler.getProductPurchases
  })

  fastify.post('/snapshot', {
    schema: {
      tags: ['products', 'report-creation'],
      querystring: DTO.Snapshot.Obj
    },
    handler: handler.createSnapshot
  })
}
