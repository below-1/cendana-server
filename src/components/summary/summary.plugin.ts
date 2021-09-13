import { FastifyInstance } from 'fastify'
import * as DTO from './summary.dto'
import * as handlers from './summary.handler'

export async function plugin(fastify: FastifyInstance) {
  fastify.get('/report1', {
    schema: {
      querystring: DTO.Report1.Obj
    },
    handler: handlers.report1
  })
}
