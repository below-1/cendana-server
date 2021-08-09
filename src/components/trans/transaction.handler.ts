import {
  FastifyRequest as Request,
  FastifyReply as Reply
} from 'fastify'
import { prisma } from '@cend/commons/prisma'
import { ID } from '@cend/commons/request'
import * as DTO from './transaction.dto'
import * as transactionServices from './service'

export type GetRequest = Request<{ Querystring: DTO.Find.Marker }>;
export type DeleteRequest = Request<{ Params: ID.Marker }>;

export async function get(request: GetRequest, reply: Reply) {
  const options = request.query
  const { type: t, ...rest } = options
  const result = await transactionServices.findTransactions(t, rest)
  reply.send(result)
}

export async function remove(request: DeleteRequest, reply: Reply) {
  const { id } = request.params
  const result = await transactionServices.remove(id)
  reply.send(result)
}