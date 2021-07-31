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
}
