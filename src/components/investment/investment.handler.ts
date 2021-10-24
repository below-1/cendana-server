import {
  FastifyRequest as Request,
  FastifyReply as Reply
} from 'fastify';
import * as DTO from './investment.dto';
import { ID } from '@cend/commons/request'
import {
  create,
  update,
  find,
  findById,
  remove as removeOne
} from './service';

type PostRequest = Request<{ Body: DTO.Create.Marker }>;
type PutRequest = Request<{ Params: ID.Marker, Body: DTO.Create.Marker }>;
type GetManyRequest = Request<{ Querystring: DTO.Find.Marker }>;
type GetOneRequest = Request<{ Params: ID.Marker }>;
type DeleteRequest = Request<{ Params: ID.Marker }>

export async function post(request: PostRequest, reply: Reply) {
  const payload = request.body
  const tool = await create(payload)
  reply.send(tool)
}

export async function put(request: PutRequest, reply: Reply) {
  const { id } = request.params
  const payload = request.body
  const result = await update(id, payload)
  reply.send(result)
}

export async function getMany(request: GetManyRequest, reply: Reply) {
  const { keyword, ...options } = request.query
  const result = await find(keyword, options)
  reply.send(result)
}

export async function getOne(request: GetOneRequest, reply: Reply) {
  const { id } = request.params
  const result = await findById(id)
  if (!result) {
    throw new Error(`can't find Tool(id=${id})`);
  }
  reply.send(result)
}

export async function remove(request: DeleteRequest, reply: Reply) {
  const { id } = request.params
  const tool = await removeOne(id)
  if (!tool) {
    throw new Error(`can't find Tool(id=${id})`);
  }
  reply.send(tool)
}
