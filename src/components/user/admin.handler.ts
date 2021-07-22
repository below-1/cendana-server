import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import { Role } from '@prisma/client';
import { ID } from '@cend/commons/request';
import * as repo from './user.repo';
import * as errors from './user.error';

type DeleteRequest = Request<{ Params: ID.Marker }>

export async function remove(request: DeleteRequest, reply: Reply) {
  const user = await repo.remove(request.params.id, Role.ADMIN);
  if (!user) {
    throw new errors.UserNotFound(``)
  }
  reply.send();
}
