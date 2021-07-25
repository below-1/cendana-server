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

  fastify.get('/:id/totals', {
    schema: {
      tags: ['purchases'],
      params: ID.Obj
    },
    handler: handler.getCurrentPurchaseTotals
  })

  fastify.get('/:id', {
    schema: {
      tags: ['purchases'],
      params: ID.Obj
    },
    handler: handler.getOne
  })

}