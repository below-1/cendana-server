import { FastifyInstance } from "fastify";
import * as handler from './sale.handler';
import * as DTO from './sale.dto';
import { ID }  from '@cend/commons/request';

export async function plugin(fastify: FastifyInstance) {

  fastify.post('/', {
    schema: {
      tags: ['sales'],
      body: DTO.Create.Obj
    },
    handler: handler.post
  })

  fastify.put('/:id', {
    schema: {
      tags: ['sales'],
      body: DTO.Update.Obj,
      params: ID.Obj
    },
    handler: handler.put
  })

  fastify.get('/:id', {
    schema: {
      tags: ['sales'],
      params: ID.Obj
    },
    handler: handler.getOne
  })

  fastify.get('/', {
    schema: {
      tags: ['sales'],
      querystring: DTO.Find.Obj
    },
    handler: handler.find
  })

  fastify.put('/:id/seal', {
    schema: {
      tags: ['sales'],
      params: ID.Obj,
      body: DTO.SealTransaction.Obj
    },
    handler: handler.seal
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['sales'],
      params: ID.Obj
    },
    handler: handler.remove
  })

}