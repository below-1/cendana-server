import { Static, Type } from '@sinclair/typebox'
import { TransactionStatus, PaymentMethod } from '@prisma/client'
import { FindOptions } from '@cend/commons/find';

export namespace Create {
  export const Obj = Type.Object({
    description: Type.Optional(Type.String()),
    authorId: Type.Number(),
    targetUserId: Type.Number(),
    createdAt: Type.Optional(Type.String({ format: 'date-time' }))
  })

  export type Marker = Static<typeof Obj>;
}

export namespace Update {
  export const Obj = Type.Object({
    description: Type.Optional(Type.String()),
    tax: Type.Number(),
    discount: Type.Number(),
    shipping: Type.String(),
    targetUserId: Type.Number()
  })

  export type Marker = Static<typeof Obj>;
}

export namespace SealTransaction {
  export const Obj = Type.Object({
    authorId: Type.Number(),
    nominal: Type.String(),
    status: Type.Enum(TransactionStatus),
    paymentMethod: Type.Enum(PaymentMethod),
    delay: Type.Optional(Type.Object({
      dueDate: Type.String({ format: 'date-time' })
    }))
  });
  export type Marker = Static<typeof Obj>;
}

export namespace AddStockItem {
  export const Obj = Type.Object({
    authorId: Type.Number(),
    productId: Type.Number(),
    buyPrice: Type.Number(),
    sellPrice: Type.Number(),
    quantity: Type.Number(),
    available: Type.Number(),
    sold: Type.Number(),
    defect: Type.Number(),
    returned: Type.Number()
  })
  export type Marker = Static<typeof Obj>;
}

export namespace RemoveStockItemParam {
  export const Obj = Type.Object({
    id: Type.Number(),
    stockItemId: Type.Number()
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