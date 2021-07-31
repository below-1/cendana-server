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
  fastify.get('/', {
    schema: {
      querystring: DTO.Find.Obj
    },
    handler: handlers.find
  })
}
