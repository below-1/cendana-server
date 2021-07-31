import { FastifyInstance } from 'fastify';
import { ID } from '@cend/commons/request';
import * as DTO from './order-item.dto';
import * as handlers from './order-item.handler';
import {
  findForProduct,
  findForSale
} from './service';


export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    schema: {
      tags: ['order-items'],
      body: DTO.Create.Obj
    },
    handler: handlers.post
  })
  fastify.put('/:id', {
    schema: {
      tags: ['order-items'],
      params: ID.Obj,
      body: DTO.Update.Obj
    },
    handler: handlers.put
  })
  fastify.delete('/:id', {
    schema: {
      tags: ['order-items'],
      params: ID.Obj
    },
    handler: handlers.remove
  })
  fastify.get('/', {
    schema: {
      tags: ['order-items'],
      querystring: DTO.Find.Obj
    },
    handler: handlers.find
  })
}
