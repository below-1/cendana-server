import { FastifyInstance } from 'fastify'
import * as DTO from './investment-trans.dto'
import { ID } from '@cend/commons/request'
import * as handlers from './investment-trans.handler'

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    handler: handlers.post,
    schema: {
      tags: ['investments'],
      body: DTO.Create.Obj
    }
  })
  fastify.put('/:id', {
    handler: handlers.put,
    schema: {
      tags: ['investments'],
      body: DTO.Update.Obj,
      params: ID.Obj
    }
  })
  fastify.delete('/:id', {
    handler: handlers.remove,
    schema: {
      tags: ['investments'],
      params: ID.Obj
    }
  })
  fastify.get('/:id', {
    handler: handlers.getOne,
    schema: {
      tags: ['investments'],
      params: ID.Obj
    }
  })
}