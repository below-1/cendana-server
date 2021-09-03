import { Static, Type } from '@sinclair/typebox'
import { TransactionStatus, PaymentMethod } from '@prisma/client'

export namespace Create {
  export const Obj = Type.Object({
    opexId: Type.Number(),
    authorId: Type.Number(),
    createdAt: Type.Optional(Type.String({ format: 'date-time' })),
    nominal: Type.String(),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod),
    description: Type.Optional(Type.String())
  })

  export type Marker = Static<typeof Obj>
}

export namespace Update {
  export const Obj = Type.Object({
    opexId: Type.Number(),
    createdAt: Type.Optional(Type.String({ format: 'date-time' })),
    nominal: Type.String(),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod),
    description: Type.Optional(Type.String())
  })
  export type Marker = Static<typeof Obj>
}
