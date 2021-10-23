import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify'
import { FindOptions } from '@cend/commons/find';
import { ID } from '@cend/commons/request'
import * as services from './service'
import * as DTO from './equity.dto';

export type PostRequest = Request<{ Body: DTO.Create.Marker }>
export type PutRequest = Request<{ Params: ID.Marker, Body: DTO.Update.Marker }>
export type DelRequest = Request<{ Params: ID.Marker }>
export type GetOneRequest = Request<{ Params: ID.Marker }>
export type GetRequest = Request<{ Querystring: FindOptions.Marker }>

export async function post(request: PostRequest, reply: Reply) {
  const result = await services.create(request.body)
  reply.send(result)
}

export async function put(request: PutRequest, reply: Reply) {
  const { id } = request.params
  const payload = request.body
  const result = await services.update(id, payload)
  reply.send(payload)
}

export async function remove(request: DelRequest, reply: Reply) {
  const { id } = request.params
  const result = await services.remove(id)
  reply.send(result)
}

export async function findOne(request: GetOneRequest, reply: Reply) {
  const { id } = request.params
  const result = await services.findOne(id)
  reply.send(result)
}

export async function find(request: GetRequest, reply: Reply) {
  const options = request.query
  const result = await services.find(options)
  reply.send(result)
}
