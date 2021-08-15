import { FastifyInstance } from 'fastify'
import * as DTO from './tool-trans.dto'
import { ID } from '@cend/commons/request'
import * as handlers from './tool-trans.handler'

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    handler: handlers.post,
    schema: {
      tags: ['tools'],
      body: DTO.Create.Obj
    }
  })
  fastify.put('/:id', {
    handler: handlers.put,
    schema: {
      tags: ['tools'],
      body: DTO.Update.Obj,
      params: ID.Obj
    }
  })
  fastify.delete('/:id', {
    handler: handlers.remove,
    schema: {
      tags: ['tools'],
      params: ID.Obj
    }
  })
  fastify.get('/:id', {
    handler: handlers.getOne,
    schema: {
      tags: ['tools'],
      params: ID.Obj
    }
  })
}