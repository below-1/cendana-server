import { FastifyInstance } from "fastify";
import * as CustomerHandlers from './customer.handler';
import * as SupplierHandlers from './supplier.handler';
import * as AdminHandlers from './admin.handler';
import * as DTO from './user.dto';
import { ID } from '@cend/commons/request'

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/customers', {
    schema: {
      tags: ['customers'],
      body: DTO.Customer.Create.Obj
    },
    handler: CustomerHandlers.post
  })

  fastify.put('/customers/:id', {
    schema: {
      tags: ['customers'],
      params: ID.Obj,
      body: DTO.Customer.Update.Obj
    },
    handler: CustomerHandlers.put
  })

  fastify.delete('/customers/:id', {
    schema: {
      tags: ['customers'],
      params: ID.Obj
    },
    handler: CustomerHandlers.remove
  })

  fastify.get('/customers', {
    schema: {
      tags: ['customers'],
      querystring: DTO.Find.Obj
    },
    handler: CustomerHandlers.getMany
  })

  fastify.post('/suppliers', {
    schema: {
      tags: ['suppliers'],
      body: DTO.Supplier.Create.Obj
    },
    handler: SupplierHandlers.post
  })

  fastify.get('/suppiers', {
    schema: {
      tags: ['suppliers'],
      querystring: DTO.Find.Obj
    },
    handler: SupplierHandlers.getMany
  })

  fastify.put('/suppliers/:id', {
    schema: {
      tags: ['suppliers'],
      params: ID.Obj,
      body: DTO.Supplier.Update.Obj
    },
    handler: SupplierHandlers.put
  })

  fastify.delete('/suppliers/:id', {
    schema: {
      tags: ['suppliers'],
      params: ID.Obj
    },
    handler: SupplierHandlers.remove
  })

  fastify.delete('/admins/:id', {
    schema: {
      tags: ['admins'],
      params: ID.Obj
    },
    handler: AdminHandlers.remove
  })
}
