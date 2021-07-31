import { FastifyInstance } from "fastify";
import * as handler from './opex.handler';
import * as DTO from './opex.dto';
import { ID }  from '@cend/commons/request';

export async function plugin(fastify: FastifyInstance) {

  fastify.post('/', {
    schema: {
      tags: ['operating-expenses'],
      body: DTO.Create.Obj,
      response: {
        200: ID.Obj
      }
    },
    handler: handler.post
  })

  fastify.put('/:id', {
    schema: {
      tags: ['operating-expenses'],
      body: DTO.Update.Obj,
      params: ID.Obj
    },
    handler: handler.put
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['operating-expenses'],
      params: ID.Obj
    },
    handler: handler.remove
  })

  fastify.get('/:id', {
    schema: {
      tags: ['operating-expenses'],
      params: ID.Obj
    },
    handler: handler.getById
  })

  fastify.get('/', {
    schema: {
      tags: ['operating-expenses'],
      querystring: DTO.Find.Obj
    },
    handler: handler.get
  })

  fastify.post('/:id/transactions', {
    handler: handler.postTransaction,
    schema: {
      tags: ['operating-expenses'],
      body: DTO.AddTransaction.Obj,
      params: ID.Obj
    }
  })

  fastify.delete('/:id/transactions/:transactionId', {
    handler: handler.deleteTransaction,
    schema: {
      tags: ['operating-expenses'],
      params: DTO.RemoveTransaction.Obj
    }
  })
}
