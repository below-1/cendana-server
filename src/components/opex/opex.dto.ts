import { Static, Type } from '@sinclair/typebox';
import { TransactionStatus, PaymentMethod } from '@prisma/client'
import { FindOptions } from '@cend/commons/find';

export namespace Create {
  export const Obj = Type.Object({
    title: Type.String(),
    // authorId: Type.Number(),
    // nominal: Type.String(),
    // status: Type.Enum(TransactionStatus),
    // paymentMethod: Type.Enum(PaymentMethod)
  });
  export type Marker = Static<typeof Obj>;
}

export namespace Update {
  export const Obj = Type.Object({
    title: Type.String(),
    // nominal: Type.String(),
    // status: Type.Enum(TransactionStatus),
    // paymentMethod: Type.Enum(PaymentMethod)
  });
  export type Marker = Static<typeof Obj>;
}

export namespace Find {
  export const Obj = Type.Intersect([
    Type.Object({
      keyword: Type.String({ default: '' })
    }),
    FindOptions.Obj
  ])

  export type Marker = Static<typeof Obj>;
}

export namespace AddTransaction {
  export const Obj = Type.Object({
    authorId: Type.Number(),
    nominal: Type.String(),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod),
    createdAt: Type.String({ format: 'date-time' })
  })
  export type Marker = Static<typeof Obj>;
}

export namespace RemoveTransaction {
  export const Obj = Type.Object({
    id: Type.Number(),
    transactionId: Type.Number()
  });
  export type Marker = Static<typeof Obj>;
}