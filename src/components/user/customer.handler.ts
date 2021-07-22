import { FastifyRequest, FastifyReply } from 'fastify'
import * as DTO from './user.dto';
import * as repo from './user.repo';
import { Role } from '@prisma/client';
import { ID } from '@cend/commons/request'

type PostRequest = FastifyRequest<{ Body: DTO.Customer.Create.Marker }>;
type PutRequest = FastifyRequest<{ 
  Params: ID.Marker,
  Body: DTO.Customer.Update.Marker
}>;
type DeleteRequest = FastifyRequest<{ Params: ID.Marker }>

export async function post(request: PostRequest, reply: FastifyReply) {
  const body = request.body;
  const payload = {
    ...body,
    role: Role.CUSTOMER
  }
  const result = await repo.create(payload);
  return result;
}

export async function put(request: PutRequest, reply: FastifyReply) {
  const payload = request.body;
  const id = request.params.id;
  const result = await repo.update(id, payload);
  return result;
}

export async function remove(request: DeleteRequest, reply: FastifyReply) {
  const id = request.params.id;
  const result = await repo.remove(id, Role.CUSTOMER);
  return result;
}
