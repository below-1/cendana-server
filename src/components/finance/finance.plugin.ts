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

  fastify.get('/perubahan-modal/:type', {
    schema: {
      tags: ['finance'],
      querystring: DTO.PerubahanModal.Obj,
      params: DTO.RespType.Obj
    },
    handler: handlers.getPerubahanModal
  })

  fastify.post('/snapshot', {
    schema: {
      tags: ['finance'],
      querystring: DTO.Snapshot.Obj
    },
    handler: handlers.postSnapshot
  })

  fastify.post('/report', {
    schema: {
      tags: ['finance'],
      body: DTO.CreateReport.Obj
    },
    handler: handlers.postReport
  })

  fastify.get('/report', {
    schema: {
      tags: ['finance'],
      querystring: DTO.FindReport.Obj
    },
    handler: handlers.getReport
  })

}
