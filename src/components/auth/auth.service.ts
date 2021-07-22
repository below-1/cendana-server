import { Role } from '@prisma/client';
import * as DTO from './auth.dto';
import { repo as userRepo } from '@cend/components/user';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';

class LoginError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'LoginError';
  }
}

export async function login(payload: DTO.Login.Marker) {
  const user = await userRepo.findOneUserByUsername(payload.username);
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
  await userRepo.create(realPayload);
}
