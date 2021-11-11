import { FastifyInstance } from 'fastify'
import * as Handlers from './roc.handler'
import * as DTO from './roc.dto'
import { ID }  from '@cend/commons/request';

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/', {
    schema: {
      tags: ['roc'],
      body: DTO.Create.Obj
    },
    handler: Handlers.create
  })

  fastify.put('/:id', {
    schema: {
      tags: ['roc'],
      body: DTO.Update.Obj,
      params: ID.Obj
    },
    handler: Handlers.update
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['roc'],
      params: ID.Obj
    },
    handler: Handlers.remove
  })

  fastify.get('/', {
    schema: {
      tags: ['roc'],
      querystring: DTO.Find.Obj
    },
    handler: Handlers.find
  })

  fastify.get('/:id', {
    schema: {
      tags: ['roc'],
      params: ID.Obj
    },
    handler: Handlers.findOne
  })
}