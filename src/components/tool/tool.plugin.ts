import { FastifyInstance } from 'fastify'
import * as handler from './tool.handler'
import { ID } from '@cend/commons/request'
import * as DTO from './tool.dto'

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    handler: handler.post,
    schema: {
      tags: ['tools'],
      body: DTO.Create.Obj
    }
  })
  fastify.put('/:id', {
    handler: handler.put,
    schema: {
      tags: ['tools'],
      params: ID.Obj,
      body: DTO.Update.Obj
    }
  })
  fastify.get('/', {
    handler: handler.getMany,
    schema: {
      tags: ['tools'],
      querystring: DTO.Find.Obj
    }
  })
  fastify.get('/:id', {
    handler: handler.getOne,
    schema: {
      tags: ['tools'],
      params: ID.Obj
    }
  })
  fastify.delete('/:id', {
    handler: handler.remove,
    schema: {
      tags: ['tools'],
      params: ID.Obj
    }
  })
}
