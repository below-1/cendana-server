import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import { Role } from '@prisma/client';
import { ID } from '@cend/commons/request';
import * as DTO from './user.dto';
import { remove as removeUser, find } from './service';
import * as errors from './user.error';

type DeleteRequest = Request<{ Params: ID.Marker }>
type GetManyRequest = Request<{ Querystring: DTO.Find.Marker }>;

export async function remove(request: DeleteRequest, reply: Reply) {
  const user = await removeUser(request.params.id, Role.ADMIN);
  if (!user) {
    throw new errors.UserNotFound(``)
  }
  reply.send();
}

export async function getMany(request: GetManyRequest, reply: Reply) {
  const { keyword, ...options } = request.query;
  const result = await find(Role.ADMIN, keyword, options);
  reply.send(result);
}