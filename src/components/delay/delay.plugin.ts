import { FastifyInstance } from 'fastify';
import * as delayHandlers from './delay.handler';
import * as paymentHandlers from './payment.handler';
import { ID } from '@cend/commons/request';
import * as DelayDTO from './delay.dto';
import * as PaymentDTO from './payment.dto';

export async function plugin(fastify: FastifyInstance) {
  fastify.get('/', {
    schema: {
      tags: ['delay'],
      querystring: DelayDTO.Find.Obj
    },
    handler: delayHandlers.get
  })

  fastify.get('/due-today', {
    schema: {
      tags: ['delay'],
      querystring: DelayDTO.DueToday.Obj
    },
    handler: delayHandlers.getDueToday
  })

  fastify.get('/:id', {
    schema: {
      tags: ['delay'],
      params: ID.Obj
    },
    handler: delayHandlers.getOne
  })

  fastify.get('/:id/payments', {
    schema: {
      tags: ['delay'],
      params: ID.Obj
    },
    handler: paymentHandlers.getPayments
  })
  fastify.post('/:id/payments', {
    schema: {
      tags: ['delay'],
      params: ID.Obj,
      body: PaymentDTO.Create.Obj
    },
    handler: paymentHandlers.postPayment
  })
  fastify.delete('/payments/:id', {
    schema: {
      tags: ['delay'],
      params: ID.Obj
    },
    handler: paymentHandlers.removePayment
  })
}
