import { FastifyInstance, FastifyRequest as Request } from 'fastify'
import { findLatestStock } from './service'
import { Static, Type } from '@sinclair/typebox'

namespace DTO {
  export const Obj = Type.Object({
    productId: Type.Number()
  })

  export type Marker = Static<typeof Obj>
}

type ReqType = Request<{ Params: DTO.Marker }>

export async function plugin(fastify: FastifyInstance) {
  fastify.get('/:productId', {
    schema: {
      params: DTO.Obj,
      tags: ['latest-stock']
    },
    handler: async (request: ReqType, reply) => {
      const { productId } = request.params
      const result = await findLatestStock(productId)
      reply.send(result)
    }
  })
}