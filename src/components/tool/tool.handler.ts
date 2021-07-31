import {
  FastifyRequest as Request,
  FastifyReply as Reply
} from 'fastify';
import * as DTO from './tool.dto';
import { ID } from '@cend/commons/request'
import {
  create,
  update
} from './service';

type PostRequest = Request<{ Body: DTO.Create.Marker }>;
type PutRequest = Request<{ Params: ID.Marker, Body: DTO.Create.Marker }>;

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
