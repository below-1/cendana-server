import { FastifyRequest, FastifyReply as  Reply } from 'fastify';
import * as DTO from './product.dto'
import { ID } from '@cend/commons/request'
import { FindOptions } from '@cend/commons/find'
import * as Services from './service'

type PostRequest = FastifyRequest<{ Body: DTO.Create.Marker }>;
type PutRequest = FastifyRequest<{ Body: DTO.Update.Marker, Params: ID.Marker }>;
type DeleteRequest = FastifyRequest<{ Params: ID.Marker }>;
type SnapshotRequest = FastifyRequest<{ Querystring: DTO.Snapshot.Marker }>
type CheckSnapshotRequest = FastifyRequest<{ Querystring: DTO.Snapshot.Marker }>

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
type PrintRequest = FastifyRequest;

export async function post(request: PostRequest, reply: Reply) {
  const result = await Services.create(request.body);
  reply.send(result);
}

export async function put(request: PutRequest, reply: Reply) {
  const { id } = request.params;
  const payload = request.body;
  const result = await Services.update(id, payload);
  reply.send(result);
}

export async function remove(request: DeleteRequest, reply: Reply) {
  const { id } = request.params;
  const result = await Services.remove(id);
  return result;
}

export async function getById(request: GetByIdRequest, reply: Reply) {
  const { id } = request.params;
  const product = await Services.findOne(id);
  if (!product) {
    throw new Error(`can't find Product(id=${id})`);
  }
  reply.send(product);
}

export async function get(request: GetRequest, reply: Reply) {
  const { keyword, ...options } = request.query;
  const result = await Services.find(keyword, options);
  reply.send(result);
}

export async function getFreeForOrder(request: GetFreeForOrderRequest, reply: Reply) {
  const options = request.query
  const { orderId, ...rest } = options
  const result = await Services.findFreeForOrder(orderId, rest)
  reply.send(result)
}

export async function getProductPurchases(request: GetPurchasesRequest, reply: Reply) {
  const options = request.query
  const { id } = request.params
  const result = await Services.findPurchases(id, options)
  reply.send(result)
}

export async function getProductSales(request: GetSalesRequest, reply: Reply) {
  const options = request.query
  const { id } = request.params
  const result = await Services.findSales(id, options)
  reply.send(result)
}

export async function createSnapshot(request: SnapshotRequest, reply: Reply) {
  const { target } = request.query
  await Services.snapshot(new Date(target))
  reply.send({
    message: 'OK'
  })
}

export async function checkSnapshot(
  request: CheckSnapshotRequest, 
  reply: Reply
) {
  const { target } = request.query
  const result = await Services.checkSnapshot(new Date(target))
  reply.send({
    result
  })
}

export async function print(request: PrintRequest, reply: Reply) {
  const stream = await Services.printProducts();
  reply
    .header('Content-Type', 'text/csv')
    .header('Content-Disposition', 'attachment;filname=products.csv')
    .send(stream);
}
