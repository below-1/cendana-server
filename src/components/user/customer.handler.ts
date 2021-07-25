import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify'
import * as DTO from './user.dto';
import * as repo from './user.repo';
import { Role } from '@prisma/client';
import { ID } from '@cend/commons/request'

type PostRequest = Request<{ Body: DTO.Customer.Create.Marker }>;
type PutRequest = Request<{ 
  Params: ID.Marker,
  Body: DTO.Customer.Update.Marker
}>;
type DeleteRequest = Request<{ Params: ID.Marker }>;

type FindRequest = {

}

type GetManyRequest = Request<{ Querystring: DTO.Find.Marker }>;

export async function post(request: PostRequest, reply: Reply) {
  const body = request.body;
  const payload = {
    ...body,
    role: Role.CUSTOMER
  }
  const result = await repo.create(payload);
  return result;
}

export async function put(request: PutRequest, reply: Reply) {
  const payload = request.body;
  const id = request.params.id;
  const result = await repo.update(id, payload);
  return result;
}

export async function remove(request: DeleteRequest, reply: Reply) {
  const id = request.params.id;
  const result = await repo.remove(id, Role.CUSTOMER);
  return result;
}

export async function getMany(request: GetManyRequest, reply: Reply) {
  const { keyword, ...options } = request.query;
  const result = await repo.findUser(Role.CUSTOMER, keyword, options);
  reply.send(result);
}
