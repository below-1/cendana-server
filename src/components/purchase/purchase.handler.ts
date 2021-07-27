import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import * as DTO from './purchase.dto';
import * as services from './service';
import { ID } from '@cend/commons/request'

type PostRequest = Request<{ Body: DTO.Create.Marker }>;
type GetOneRequest = Request<{ Params: ID.Marker }>;
type SealRequest = Request<{ Params: ID.Marker, Body: DTO.SealTransaction.Marker }>;

export async function post(request: PostRequest, reply: Reply) {
  const payload = request.body;
  const purchase = await services.create(payload);
  reply.send(purchase);
}

export async function getOne(request: GetOneRequest, reply: Reply) {
  const purchase = await services.findById(request.params.id)
  reply.send(purchase);
}

export async function seal(request: SealRequest, reply: Reply) {
  const { id } = request.params;
  const payload = {
    orderId: id,
    ...request.body
  };
  const result = await services.sealTransaction(payload);
  reply.send(result);
}
