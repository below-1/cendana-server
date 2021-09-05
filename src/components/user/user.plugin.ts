import { FastifyInstance } from "fastify";
import * as CustomerHandlers from './customer.handler';
import * as SupplierHandlers from './supplier.handler';
import * as StafHandlers from './staf.handler'
import * as AdminHandlers from './admin.handler';
import * as DTO from './user.dto';
import { ID } from '@cend/commons/request'

export async function plugin(fastify: FastifyInstance) {

  fastify.post('/stafs', {
    schema: {
      tags: ['stafs'],
      body: DTO.Staf.Create.Obj
    },
    handler: StafHandlers.post
  })

  fastify.put('/stafs/:id', {
    schema: {
      tags: ['stafs'],
      params: ID.Obj,
      body: DTO.Staf.Update.Obj
    },
    handler: StafHandlers.put
  })

  fastify.delete('/stafs/:id', {
    schema: {
      tags: ['stafs'],
      params: ID.Obj
    },
    handler: StafHandlers.remove
  })

  fastify.get('/stafs', {
    schema: {
      tags: ['stafs'],
      querystring: DTO.Find.Obj
    },
    handler: StafHandlers.getMany
  })

  fastify.get('/stafs/:id', {
    schema: {
      tags: ['stafs'],
      params: ID.Obj
    },
    handler: CustomerHandlers.getOne
  })

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

  fastify.get('/customers/:id', {
    schema: {
      tags: ['customers'],
      params: ID.Obj
    },
    handler: CustomerHandlers.getOne
  })

  fastify.post('/suppliers', {
    schema: {
      tags: ['suppliers'],
      body: DTO.Supplier.Create.Obj
    },
    handler: SupplierHandlers.post
  })

  fastify.get('/suppliers', {
    schema: {
      tags: ['suppliers'],
      querystring: DTO.Find.Obj
    },
    handler: SupplierHandlers.getMany
  })

  fastify.get('/suppliers/:id', {
    schema: {
      tags: ['suppliers'],
      params: ID.Obj
    },
    handler: SupplierHandlers.getOne
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

  fastify.get('/admins', {
    schema: {
      tags: ['admins'],
      querystring: DTO.Find.Obj
    },
    handler: AdminHandlers.getMany
  })
  fastify.delete('/admins/:id', {
    schema: {
      tags: ['admins'],
      params: ID.Obj
    },
    handler: AdminHandlers.remove
  })
}
