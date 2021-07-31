import { Static, Type } from '@sinclair/typebox';
import {
  TransactionStatus,
  PaymentMethod
} from '@prisma/client';

export namespace Create {
  export const Obj = Type.Object({
    authorId: Type.Number(),
    nominal: Type.String(),
    createdAt: Type.String({ format: 'date-time' }),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod)
  })

  export type Marker = Static<typeof Obj>;
}
