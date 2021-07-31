import { FastifyInstance } from "fastify";
import * as handler from './opex.handler';
import * as DTO from './opex.dto';
import { ID }  from '@cend/commons/request';

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
}
