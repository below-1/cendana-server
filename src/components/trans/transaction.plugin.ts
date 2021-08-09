import { FastifyInstance } from 'fastify'
import { ID } from '@cend/commons/request'
import * as DTO from './transaction.dto'
import * as handlers from './transaction.handler'

export async function plugin(fastify: FastifyInstance) {
  fastify.get('/', {
    schema: {
      tags: ['transactions'],
      querystring: DTO.Find.Obj
    },
    handler: handlers.get
  })

  fastify.delete('/:id', {
    schema: {
      tags: ['transactions'],
      params: ID.Obj
    },
    handler: handlers.remove
  })
}
