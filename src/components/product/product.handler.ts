import { FastifyRequest, FastifyReply as  Reply } from 'fastify';
import * as DTO from './product.dto'
import { ID } from '@cend/commons/request'
import * as repo from './product.repo'
import * as views from './product.view'

type PostRequest = FastifyRequest<{ Body: DTO.Create.Marker }>;
type PutRequest = FastifyRequest<{ Body: DTO.Update.Marker, Params: ID.Marker }>;
type DeleteRequest = FastifyRequest<{ Params: ID.Marker }>;
type GetByIdRequest = FastifyRequest<{ Params: ID.Marker }>;
type GetRequest = FastifyRequest<{ Querystring: DTO.Find.Marker }>;

export async function post(request: PostRequest, reply: Reply) {
  const result = await repo.create(request.body);
  reply.send(result);
}

export async function put(request: PutRequest, reply: Reply) {
  const { id } = request.params;
  const payload = request.body;
  const result = await repo.update(id, payload);
  reply.send(result);
}

export async function remove(request: DeleteRequest, reply: Reply) {
  const { id } = request.params;
  const result = await repo.remove(id);
  return result;
}

export async function getById(request: GetByIdRequest, reply: Reply) {
  const { id } = request.params;
  const product = await views.findOne(id);
  if (!product) {
    throw new Error(`can't find Product(id=${id})`);
  }
  reply.send(product);
}

export async function get(request: GetRequest, reply: Reply) {
  const { keyword, ...options } = request.query;
  const result = await views.find(keyword, options);
  reply.send(result);
}
