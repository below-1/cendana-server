import { FastifyInstance } from "fastify";
import { FindOptions } from '@cend/commons/find'
import { ID }  from '@cend/commons/request';
import * as handlers from './equity.handler';
import * as DTO from './equity.dto';

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    schema: {
      body: DTO.Create.Obj
    },
    handler: handlers.post
  })

  fastify.put('/:id', {
    schema: {
      params: ID.Obj,
      body: DTO.Update.Obj
    },
    handler: handlers.put
  })

  fastify.delete('/:id', {
    schema: {
      params: ID.Obj
    },
    handler: handlers.remove
  })

  fastify.get('/:id', {
    schema: {
      params: ID.Obj
    },
    handler: handlers.findOne
  })

  fastify.get('/', {
    schema: {
      querystring: FindOptions.Obj
    },
    handler: handlers.find
  })
}