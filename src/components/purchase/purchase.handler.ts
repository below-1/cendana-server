import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import * as DTO from './purchase.dto';
import * as services from './purchase.service';
import * as views from './purchase.view';
import { ID } from '@cend/commons/request'

type PostRequest = Request<{ Body: DTO.Create.Marker }>;
type PurchaseTotalsRequest = Request<{ Params: ID.Marker }>;
type GetOneRequest = Request<{ Params: ID.Marker }>;

export async function post(request: PostRequest, reply: Reply) {
  const payload = request.body;
  const purchase = await services.create(payload);
  reply.send(purchase);
}

export async function getCurrentPurchaseTotals(request: PurchaseTotalsRequest, reply: Reply) {
  const orderId = request.params.id;
  const totals = await services.getCurrentPurchaseTotals(orderId);
  reply.send(totals);
}

export async function getOne(request: GetOneRequest, reply: Reply) {
  const purchase = await views.findPurchaseById(request.params.id)
  reply.send(purchase);
}