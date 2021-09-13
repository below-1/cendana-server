import {
  FastifyRequest as Request,
  FastifyReply as Reply
} from 'fastify'
import * as DTO from './summary.dto'
import * as service from './service'

type Report1Request = Request<{ Querystring: DTO.Report1.Marker }>

export async function report1(request: Report1Request, reply: Reply) {
  const items = await service.report1(request.query)
  return items
}
