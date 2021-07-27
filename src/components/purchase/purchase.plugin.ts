import { FastifyInstance } from "fastify";
import * as handler from './purchase.handler';
import * as DTO from './purchase.dto';
import { ID }  from '@cend/commons/request';

export async function plugin(fastify: FastifyInstance) {

  fastify.post('/', {
    schema: {
      tags: ['purchases'],
      body: DTO.Create.Obj
    },
    handler: handler.post
  })

  fastify.get('/:id', {
    schema: {
      tags: ['purchases'],
      params: ID.Obj
    },
    handler: handler.getOne
  })

  fastify.put('/:id/seal', {
    schema: {
      tags: ['purchases'],
      params: ID.Obj,
      body: DTO.SealTransaction.Obj
    },
    handler: handler.seal
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['purchases'],
      params: ID.Obj
    },
    handler: handler.remove
  })

}