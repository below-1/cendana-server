import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify';
import * as DTO from './auth.dto';
import * as services from './auth.service';

type LoginRequest = Request<{ Body: DTO.Login.Marker }>;
type SignupRequest = Request<{ Body: DTO.SignUp.Marker }>;
type ChangePassRequest = Request<{ Body: DTO.ChangePassword.Marker }>

export async function login(request: LoginRequest, reply: Reply) {
  const token = await services.login(request.body);
  reply.send({ token });
}

export async function signup(request: SignupRequest, reply: Reply) {
  await services.signup(request.body);
  reply.send();
}

export async function currentUser(request: Request, reply: Reply) {
  const authHeader = request.headers.authorization;
  if (!authHeader) {
    reply.status(400).send({
      message: 'authorization header not provided'
    });
    return;
  }
  const token = authHeader!.split(' ')[1];
  console.log(token);
  const user = await services.currentUser(token);
  reply.send(user);
}

export async function changePassword(request: ChangePassRequest, reply: Reply) {
  const {
    username,
    password
  } = request.body
  const result = await services.changePassword(username, password)
  if (!result) {
    throw new Error('Fail when changing password')
  }
  reply.send({
    message: 'OK'
  })
}
