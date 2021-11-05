import { 
  FastifyRequest as Request,
  FastifyReply as Reply
} from 'fastify'
import { ID } from '@cend/commons/request'
import * as DTO from './investment-trans.dto'
import * as services from './service'

type PostRequest = Request<{ Body: DTO.Create.Marker }>
type PutRequest = Request<{ Params: ID.Marker, Body: DTO.Update.Marker }>
type DelRequest = Request<{ Params: ID.Marker }>
type GetOneRequest = Request<{ Params: ID.Marker }>

export async function post(request: PostRequest, reply: Reply) {
  const { body: payload } = request
  const trans = await services.create(payload)
  reply.send(trans)
}

export async function put(request: PutRequest, reply: Reply) {
  const { id } = request.params
  const { body: payload } = request
  const trans = await services.update(id, payload)
  reply.send(trans)
}

export async function remove(request: DelRequest, reply: Reply) {
  const { id } = request.params
  const trans = await services.remove(id)
}

export async function getOne(request: DelRequest, reply: Reply) {
  const { id } = request.params
  const trans = await services.findOne(id)
  if (!trans) {
    throw new Error(`Opex(${id}) can't be found`)
  }
  reply.send(trans)
}
