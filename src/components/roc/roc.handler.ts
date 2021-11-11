import {
  FastifyRequest as Request,
  FastifyReply as Reply
} from 'fastify'
import { FindOptions } from '@cend/commons/find';
import { ID } from '@cend/commons/request'
import * as Services from './service'
import * as DTO from './roc.dto'

type CreateRequest = Request<{ Body: DTO.Create.Marker }>
type UpdateRequest = Request<{ 
  Params: ID.Marker, 
  Body: DTO.Update.Marker 
}>
type RemoveRequest = Request<{ Params: ID.Marker }>
type FindRequest = Request<{ Querystring: DTO.Find.Marker }>
type FindOneRequest = Request<{ Params: ID.Marker }>

export async function create(request: CreateRequest, reply: Reply) {
  const result = await Services.create(request.body)
  reply.send(result)
}

export async function update(request: UpdateRequest, reply: Reply) {
  const { id } = request.params
  const payload = request.body
  await Services.update(id, payload)
}

export async function remove(request: RemoveRequest, reply: Reply) {
  const { id } = request.params
  await Services.remove(id)
}

export async function find(request: FindRequest, reply: Reply) {
  const {
    year,
    month,
    keyword,
    ...options
  } = request.query
  const result = await Services.find({ year, month, keyword }, options)
  reply.send(result)
}

export async function findOne(request: FindOneRequest, reply: Reply) {
  const result = await Services.findOne(request.params.id)
}
