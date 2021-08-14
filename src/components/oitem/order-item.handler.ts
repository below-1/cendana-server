import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import * as DTO from './order-item.dto';
import {
  create,
  update,
  remove as removeStockItem,
  findForSale,
  findForProduct,
  findById
} from './service';
import { ID } from '@cend/commons/request'

type PostRequest = Request<{ Body: DTO.Create.Marker }>;
type PutRequest = Request<{ Params: ID.Marker, Body: DTO.Update.Marker }>;
type RemoveRequest = Request<{ Params: ID.Marker }>;
type FindRequest = Request<{ Querystring: DTO.Find.Marker }>;
type FindOneRequest = Request<{ Params: ID.Marker }>;

export async function post(request: PostRequest, reply: Reply) {
  const payload = request.body;
  const stockItem = await create(payload);
  reply.send(stockItem);
}

export async function put(request: PutRequest, reply: Reply) {
  const { id } = request.params;
  const payload = request.body;
  const stockItem = await update(id, payload);
  reply.send(stockItem);
}

export async function remove(request: RemoveRequest, reply: Reply) {
  const { id } = request.params;
  const stockItem = await removeStockItem(id);
  reply.send(stockItem);
}

export async function find(request: FindRequest, reply: Reply) {
  const options = request.query;
  const { type, target, ...rest } = options;
  if (options.type == DTO.Find.Filter.ORDER) {
    const items = await findForSale(target, rest);
    reply.send(items);
  } else if (options.type == DTO.Find.Filter.PRODUCT) {
    const result = await findForProduct(target, rest);
    reply.send(result);
  } else {
    throw new Error(`filter is not valid`);
  }
}

export async function findOne(request: FindOneRequest, reply: Reply) {
  const { id } = request.params
  const result = await findById(id)
  reply.send(result)
}