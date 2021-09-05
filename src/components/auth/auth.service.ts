import { prisma } from '@cend/commons/prisma';
import { Role } from '@prisma/client';
import * as DTO from './auth.dto';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import {
  services as userServices
} from '@cend/components/user';

class LoginError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'LoginError';
  }
}

export async function login(payload: DTO.Login.Marker) {
  const user = await userServices.findOneUserByUsername(payload.username);
  if (!user) {
    throw new LoginError('USER_NOT_FOUND');
  }
  const passwordMatch = await bcrypt.compare(payload.password, user.password!);
  if (!passwordMatch) {
    throw new LoginError('PASSWORD_NOT_MATCH');
  }
  const token = await jwt.sign({
    username: user.username,
    role: user.role,
    name: user.name
  }, process.env.JWT_SECRET || 'fooboar');
  return token;
}

export async function signup(payload: DTO.SignUp.Marker) {
  const hashedPassword = await bcrypt.hash(payload.password, 2);
  const realPayload = {
    ...payload,
    password: hashedPassword,
    role: Role.ADMIN
  };
  await userServices.create(realPayload);
}

export async function currentUser(token: string) {
  const authObject: any = await jwt.verify(token, process.env.JWT_SECRET!);
  const user = await userServices.findOneUserByUsername(authObject.username);
  return user;
}

export async function changePassword(username: string, password: string) {
  const hashedPassword = await bcrypt.hash(password, 2);
  const result = await prisma.user.updateMany({
    where: {
      username
    },
    data: {
      password: hashedPassword
    }
  })
  const isSuccess = result.count == 1
  return isSuccess
}