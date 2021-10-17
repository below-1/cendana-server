import { FastifyInstance } from 'fastify';
import * as handlers from './finance.handler'
import * as DTO from './finance.dto'

export async function plugin(fastify: FastifyInstance) {

  fastify.get('/laba-rugi/:type', {
    schema: {
      tags: ['finance'],
      querystring: DTO.LabaRugi.Obj,
      params: DTO.RespType.Obj
    },
    handler: handlers.getLabaRugi
  })

}
