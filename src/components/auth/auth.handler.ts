import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import * as DTO from './auth.dto';
import * as services from './auth.service';

type LoginRequest = Request<{ Body: DTO.Login.Marker }>;
type SignupRequest = Request<{ Body: DTO.SignUp.Marker }>;

export async function login(request: LoginRequest, reply: Reply) {
  const token = await services.login(request.body);
  reply.send(token);
}

export async function signup(request: SignupRequest, reply: Reply) {
  await services.signup(request.body);
  reply.send();
}
