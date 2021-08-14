import { FastifyInstance } from 'fastify'
import * as DTO from './opex-trans.dto'
import { ID } from '@cend/commons/request'
import * as handlers from './opex-trans.handler'

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    handler: handlers.post,
    schema: {
      tags: ['operating-expenses'],
      body: DTO.Create.Obj
    }
  })
  fastify.put('/:id', {
    handler: handlers.put,
    schema: {
      tags: ['operating-expenses'],
      body: DTO.Update.Obj,
      params: ID.Obj
    }
  })
  fastify.delete('/:id', {
    handler: handlers.remove,
    schema: {
      tags: ['operating-expenses'],
      params: ID.Obj
    }
  })
  fastify.get('/:id', {
    handler: handlers.getOne,
    schema: {
      tags: ['operating-expenses'],
      params: ID.Obj
    }
  })
}