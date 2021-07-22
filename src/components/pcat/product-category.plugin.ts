import { FastifyInstance } from 'fastify'
import * as handler from './product-category.handler'
import * as DTO from './product-category.dto'
import { ID }  from '@cend/commons/request';

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    schema: {
      tags: ['product-categories'],
      body: DTO.Create.Obj,
      response: {
        200: ID.Obj
      }
    },
    handler: handler.post
  })

  fastify.put('/:id', {
    schema: {
      tags: ['product-categories'],
      params: ID.Obj,
      body: DTO.Update.Obj
    },
    handler: handler.put
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['product-categories'],
      params: ID.Obj,
    },
    handler: handler.remove
  })
}
