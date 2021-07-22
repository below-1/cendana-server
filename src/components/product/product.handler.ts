import { FastifyRequest, FastifyReply } from 'fastify';
import * as DTO from './product.dto'
import { ID } from '@cend/commons/request'
import * as repo from './product.repo'

type PostRequest = FastifyRequest<{ Body: DTO.Create.Marker }>;
type PutRequest = FastifyRequest<{ Body: DTO.Update.Marker, Params: ID.Marker }>;
type DeleteRequest = FastifyRequest<{ Params: ID.Marker }>;

export async function post(request: PostRequest, reply: FastifyReply) {
  const result = await repo.create(request.body);
  reply.send(result);
}

export async function put(request: PutRequest, reply: FastifyReply) {
  const { id } = request.params;
  const payload = request.body;
  const result = await repo.update(id, payload);
  reply.send(result);
}

export async function remove(request: DeleteRequest, reply: FastifyReply) {
  const { id } = request.params;
  const result = await repo.remove(id);
  return result;
}