import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import { Role } from '@prisma/client';
import { ID } from '@cend/commons/request';
import { remove as removeUser } from './service';
import * as errors from './user.error';

type DeleteRequest = Request<{ Params: ID.Marker }>

export async function remove(request: DeleteRequest, reply: Reply) {
  const user = await removeUser(request.params.id, Role.ADMIN);
  if (!user) {
    throw new errors.UserNotFound(``)
  }
  reply.send();
}
