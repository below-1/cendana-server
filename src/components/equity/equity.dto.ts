import { Static, Type } from '@sinclair/typebox';
import { TransactionType, TransactionStatus, PaymentMethod } from '@prisma/client'

export namespace Create {
  export const Obj = Type.Object({
    user: Type.String(),
    nominal: Type.String(),
    authorId: Type.Number(),
    createdAt: Type.Optional(Type.String({ format: 'date-time' })),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod),
    type: Type.Enum(TransactionType)
  })

  export type Marker = Static<typeof Obj>
}

export namespace Update {
  export const Obj = Type.Object({
    user: Type.String(),
    nominal: Type.String(),
    authorId: Type.Number(),
    createdAt: Type.Optional(Type.String({ format: 'date-time' })),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod),
    type: Type.Enum(TransactionType)
  })

  export type Marker = Static<typeof Obj>
}
