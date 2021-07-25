import { FastifyInstance } from 'fastify'
import * as handler from './opex-category.handler'
import * as DTO from './opex-category.dto'
import { ID }  from '@cend/commons/request';

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    schema: {
      tags: ['opex-categories'],
      body: DTO.Create.Obj,
      response: {
        200: ID.Obj
      }
    },
    handler: handler.post
  })

  fastify.put('/:id', {
    schema: {
      tags: ['opex-categories'],
      params: ID.Obj,
      body: DTO.Update.Obj
    },
    handler: handler.put
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['opex-categories'],
      params: ID.Obj,
    },
    handler: handler.remove
  })
}
