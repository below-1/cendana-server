import { FastifyRequest, FastifyReply as  Reply } from 'fastify';
import * as DTO from './product.dto'
import { ID } from '@cend/commons/request'
import { FindOptions } from '@cend/commons/find'
import {
  create,
  update,
  remove as removeProduct,
  find,
  findOne,
  findFreeForOrder,
  findPurchases,
  findSales,
  snapshot
} from './service';

type PostRequest = FastifyRequest<{ Body: DTO.Create.Marker }>;
type PutRequest = FastifyRequest<{ Body: DTO.Update.Marker, Params: ID.Marker }>;
type DeleteRequest = FastifyRequest<{ Params: ID.Marker }>;
type SnapshotRequest = FastifyRequest<{ Querystring: DTO.Snapshot.Marker }>
type GetByIdRequest = FastifyRequest<{ Params: ID.Marker }>;
type GetRequest = FastifyRequest<{ Querystring: DTO.Find.Marker }>;
type GetFreeForOrderRequest = FastifyRequest<{ Querystring: DTO.FindFreeForOrder.Marker }>;
type GetPurchasesRequest = FastifyRequest<{
  Params: ID.Marker,
  Querystring: FindOptions.Marker
}>
type GetSalesRequest = FastifyRequest<{
  Params: ID.Marker,
  Querystring: FindOptions.Marker
}>

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
  const result = await removeProduct(id);
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

export async function getFreeForOrder(request: GetFreeForOrderRequest, reply: Reply) {
  const options = request.query
  const { orderId, ...rest } = options
  const result = await findFreeForOrder(orderId, rest)
  reply.send(result)
}

export async function getProductPurchases(request: GetPurchasesRequest, reply: Reply) {
  const options = request.query
  const { id } = request.params
  const result = await findPurchases(id, options)
  reply.send(result)
}

export async function getProductSales(request: GetSalesRequest, reply: Reply) {
  const options = request.query
  const { id } = request.params
  const result = await findSales(id, options)
  reply.send(result)
}

export async function createSnapshot(request: SnapshotRequest, reply: Reply) {
  const { target } = request.query
  await snapshot(new Date(target))
  reply.send({
    message: 'OK'
  })
}
