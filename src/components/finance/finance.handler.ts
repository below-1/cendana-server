import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify'
import { labaRugi } from './service'
import * as DTO from './finance.dto';

export type GetLabaRugi = Request<{ Querystring: DTO.LabaRugi.Marker }>;

export async function getLabaRugi(request: GetLabaRugi, reply: Reply) {
  const result = await labaRugi(request.query)
  reply.send(result)
}
