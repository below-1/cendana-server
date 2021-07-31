import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import { ID } from '@cend/commons/request';
import * as DTO from './payment.dto';
import { findPayments, addPayment } from './service';

export type GetPaymentsRequest = Request<{ Params: ID.Marker }>;
export type AddPaymentRequest = Request<{ Params: ID.Marker, Body: DTO.Create.Marker }>;

export async function getPayments(request: GetPaymentsRequest, reply: Reply) {
  const { id: delayId } = request.params;
  const payments = await findPayments(delayId);
  reply.send(payments);
}

export async function postPayment(request: AddPaymentRequest, reply: Reply) {
  const payload = request.body;
  const { id } = request.params;
  const transaction = await addPayment({
    delayId: id,
    ...payload
  });
  reply.send(transaction);
}
