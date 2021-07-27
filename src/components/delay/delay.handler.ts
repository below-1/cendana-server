import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import { ID } from '@cend/commons/request';
import { findOne, find } from './service';
import * as DTO from './delay.dto';

export type GetOneRequest = Request<{ Params: ID.Marker }>;
export type GetRequest = Request<{ Querystring: DTO.Find.Marker }>;

export async function getOne(request: GetOneRequest, reply: Reply) {
  const { id } = request.params;
  const delay = await findOne(id);
  if (!delay) {
    throw new Error(`Delay(id=${id}) can't be found`);
  }
  reply.send(delay);
}

export async function get(request: GetRequest, reply: Reply) {
  const options = request.query;
  const result = await find(options);
  reply.send(result);
}
