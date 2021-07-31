import { FastifyRequest as Request, FastifyReply as  Reply } from 'fastify';
import * as DTO from './opex.dto'
import { ID } from '@cend/commons/request'
import {
  create,
  update,
  remove as removeOpex,
  find,
  findOne
} from './service';

type PostRequest = Request<{ Body: DTO.Create.Marker }>;
type PutRequest = Request<{ Body: DTO.Update.Marker, Params: ID.Marker }>;
type DeleteRequest = Request<{ Params: ID.Marker }>;
type GetByIdRequest = Request<{ Params: ID.Marker }>;
type GetRequest = Request<{ Querystring: DTO.Find.Marker }>;

export async function post(request: PostRequest, reply: Reply) {
  const result = await create(request.body);
  reply.send(result);
}

export async function put(request: PutRequest, reply: Reply) {
  const { id } = request.params;
  const payload = request.body;
  const result = await update(id, payload);
  reply.send(result);
}

export async function remove(request: DeleteRequest, reply: Reply) {
  const { id } = request.params;
  const result = await removeOpex(id);
  return result;
}

export async function getById(request: GetByIdRequest, reply: Reply) {
  const { id } = request.params;
  const product = await findOne(id);
  if (!product) {
    throw new Error(`can't find Product(id=${id})`);
  }
  reply.send(product);
}

export async function get(request: GetRequest, reply: Reply) {
  const { keyword, ...options } = request.query;
  const result = await find(keyword, options);
  reply.send(result);
}
