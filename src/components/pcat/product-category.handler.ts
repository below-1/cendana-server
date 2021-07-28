import { FastifyRequest, FastifyReply } from 'fastify'
import {
  create,
  update,
  remove as removeProductCategory,
  find as findProductCategory,
  findOne as findOneProductCategory
} from './service';
import * as DTO from './product-category.dto'
import { ID } from '@cend/commons/request';

type PostRequest = FastifyRequest<{ Body: DTO.Create.Marker }>;
type PutRequest = FastifyRequest<{ Params: ID.Marker, Body: DTO.Update.Marker }>;
type DeleteRequest = FastifyRequest<{ Params: ID.Marker }>;
type FindRequest = FastifyRequest<{ Querystring: DTO.Find.Marker }>;
type FindOneRequest = FastifyRequest<{ Params: ID.Marker }>;

export async function post(request: PostRequest, reply: FastifyReply) {
  const result = await create(request.body);
  reply.send(result);
}

export async function put(request: PutRequest, reply: FastifyReply) {
  const { id } = request.params;
  const payload = request.body;
  const result = await update(id, payload);
  reply.send(result);
}

export async function remove(request: DeleteRequest, reply: FastifyReply) {
  const { id } = request.params;
  const result = await removeProductCategory(id);
  reply.send(result);
}

export async function find(request: FindRequest, reply: FastifyReply) {
  const { keyword, ...options } = request.query;
  let _keyword = keyword ? keyword : '';
  const result = await findProductCategory(_keyword, options);
  reply.send(result);
}

export async function findOne(request: FindOneRequest, reply: FastifyReply) {
  const productCategory = await findOneProductCategory(request.params.id);
  if (!productCategory) {
    throw new Error(`can't find ProductCategory(id=${request.params.id})`);
  }
  reply.send(productCategory);
}