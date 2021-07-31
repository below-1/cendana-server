import { FastifyInstance } from "fastify";
import * as DTO from './auth.dto';
import * as handlers from './auth.handler';

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/login', {
    schema: {
      body: DTO.Login.Obj
    },
    handler: handlers.login
  })

  fastify.post('/signup', {
    schema: {
      body: DTO.SignUp.Obj
    },
    handler: handlers.signup
  })

  fastify.get('/me', {
    handler: handlers.currentUser
  })
}