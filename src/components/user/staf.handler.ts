import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify'
import bcrypt from 'bcrypt';
import * as DTO from './user.dto';
import { Role } from '@prisma/client';
import { ID } from '@cend/commons/request'
import {
  create,
  update,
  remove as removeUser,
  find,
  findById
} from './service';

type PostRequest = Request<{ Body: DTO.Staf.Create.Marker }>;
type PutRequest = Request<{ 
  Params: ID.Marker,
  Body: DTO.Staf.Update.Marker
}>;
type DeleteRequest = Request<{ Params: ID.Marker }>;
type GetOneRequest = Request<{ Params: ID.Marker }>;
type GetManyRequest = Request<{ Querystring: DTO.Find.Marker }>;

/**
*  Adding staf must be provided with password.
*  We're adding it directly in this handler
*/
export async function post(request: PostRequest, reply: Reply) {
  const body = request.body;
  const password = await bcrypt.hash(body.password, 2)
  const payload = {
    ...body,
    password,
    role: Role.STAF
  }
  const result = await create(payload);
  return result;
}

export async function put(request: PutRequest, reply: Reply) {
  const payload = request.body;
  const id = request.params.id;
  const result = await update(id, payload);
  return result;
}

export async function remove(request: DeleteRequest, reply: Reply) {
  const id = request.params.id;
  const result = await removeUser(id, Role.STAF);
  return result;
}

export async function getMany(request: GetManyRequest, reply: Reply) {
  const { keyword, ...options } = request.query;
  const result = await find(Role.STAF, keyword, options);
  reply.send(result);
}

export async function getOne(request: GetOneRequest, reply: Reply) {
  const { id } = request.params
  const result = await findById(id)
  reply.send(result)
}
