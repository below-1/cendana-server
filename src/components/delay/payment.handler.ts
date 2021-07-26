import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import { ID } from '@cend/commons/request';
import * as paymentViews from './payment.view';
import * as DTO from './payment.dto';

export type GetPaymentsRequest = Request<{ Params: ID.Marker }>;
export type AddPaymentRequest = Request<{ Params: ID.Marker, Body: DTO.Create.Marker }>;

export async function getPayments(request: GetPaymentsRequest, reply: Reply) {
  const { id: delayId } = request.params;
  const payments = await paymentViews.findForDelay(delayId);
  reply.send(payments);
}

export async function addPayment(request: AddPaymentRequest, reply: Reply) {
  reply.send('OK');
}
