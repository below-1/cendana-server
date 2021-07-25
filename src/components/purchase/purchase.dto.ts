import { Static, Type } from '@sinclair/typebox'
import { TransactionStatus, PaymentMethod } from '@prisma/client'

export namespace Create {
  export const Obj = Type.Object({
    // tax: Type.Number({ default: 0 }),
    // shipping: Type.Number({ default: 0 }),
    // subTotal: Type.Number(),
    // grandTotal: Type.Number(),
    // discount: Type.Number({ default: 0 }),
    // promo: Type.Optional(Type.String()),
    description: Type.Optional(Type.String()),
    authorId: Type.Number(),
    targetUserId: Type.Number(),
    createdAt: Type.Optional(Type.String({ format: 'date-time' }))
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
