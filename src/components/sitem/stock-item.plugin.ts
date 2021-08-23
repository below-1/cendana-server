import { FastifyInstance } from "fastify";
import * as DTO from './stock-item.dto';
import * as handlers from './stock-item.handler';
import { ID }  from '@cend/commons/request';

export async function plugin(fastify: FastifyInstance) {

  fastify.post('/', {
    schema: {
      tags: ['stock-items'],
      body: DTO.Create.Obj
    },
    handler: handlers.post
  })

  fastify.put('/:id', {
    schema: {
      tags: ['stock-items'],
      body: DTO.Update.Obj,
      params: ID.Obj
    },
    handler: handlers.put
  })

  fastify.put('/:id/defect', {
    schema: {
      tags: ['stock-items'],
      body: DTO.ChangeDefect.Obj,
      params: ID.Obj
    },
    handler: handlers.putDefect
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['stock-items'],
      params: ID.Obj
    },
    handler: handlers.remove
  })

  fastify.get('/', {
    schema: {
      tags: ['stock-items'],
      querystring: DTO.Find.Obj
    },
    handler: handlers.find
  })

  fastify.get('/:id', {
    schema: {
      tags: ['stock-items'],
      params: ID.Obj
    },
    handler: handlers.getOne
  })
  
}