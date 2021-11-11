import { Static, Type } from '@sinclair/typebox'
import { TransactionStatus, PaymentMethod } from '@prisma/client'
import { FindOptions } from '@cend/commons/find';

export namespace Create {
  export const Obj = Type.Object({
    nominal: Type.Number(),
    createdAt: Type.Optional(Type.String({ format: 'date-time' })),
    authorId: Type.Number(),
    targetUserId: Type.Number(),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod)
  })

  export type Marker = Static<typeof Obj>;
}

export namespace Update {
  export const Obj = Type.Object({
    nominal: Type.Number(),
    authorId: Type.Number(),
    targetUserId: Type.Number(),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod)
  })

  export type Marker = Static<typeof Obj>;
}

export namespace Find {
  export const Obj = Type.Intersect([
    Type.Object({
      keyword: Type.String({ default: '' }),
      year: Type.Number(),
      month: Type.Number()
    }),
    FindOptions.Obj
  ])

  export type Marker = Static<typeof Obj>;
}
