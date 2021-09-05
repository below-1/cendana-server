import { FastifyInstance } from "fastify";
import * as DTO from './auth.dto';
import * as handlers from './auth.handler';

export async function plugin(fastify: FastifyInstance) {
  fastify.post('/login', {
    schema: {
      tags: ['auth'],
      body: DTO.Login.Obj
    },
    handler: handlers.login
  })

  fastify.post('/signup', {
    schema: {
      tags: ['auth'],
      body: DTO.SignUp.Obj
    },
    handler: handlers.signup
  })

  fastify.get('/me', {
    schema: {
      tags: ['auth']
    },
    handler: handlers.currentUser
  })

  fastify.put('/change-password', {
    schema: {
      tags: ['auth'],
      body: DTO.ChangePassword.Obj
    },
    handler: handlers.changePassword
  })
}
