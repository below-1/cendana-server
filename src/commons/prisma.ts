import { PrismaClient } from '@prisma/client'

const log: any = process.env.NODE_ENV == 'development' 
  ? ['query', 'info', `warn`, `error`] 
  : undefined;

export const prisma = new PrismaClient({
  log
});
