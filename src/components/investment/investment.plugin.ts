import { FastifyInstance } from 'fastify'
import * as handler from './investment.handler'
import { ID } from '@cend/commons/request'
import * as DTO from './investment.dto'

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    handler: handler.post,
    schema: {
      tags: ['investment'],
      body: DTO.Create.Obj
    }
  })
  fastify.put('/:id', {
    handler: handler.put,
    schema: {
      tags: ['investment'],
      params: ID.Obj,
      body: DTO.Update.Obj
    }
  })
  fastify.get('/', {
    handler: handler.getMany,
    schema: {
      tags: ['investment'],
      querystring: DTO.Find.Obj
    }
  })
  fastify.get('/:id', {
    handler: handler.getOne,
    schema: {
      tags: ['investment'],
      params: ID.Obj
    }
  })
  fastify.delete('/:id', {
    handler: handler.remove,
    schema: {
      tags: ['investment'],
      params: ID.Obj
    }
  })
}
