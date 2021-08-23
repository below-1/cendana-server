import { Static, Type } from '@sinclair/typebox';
import { FindOptions as BaseFind } from '@cend/commons/find';

export namespace Create {
  export const Obj = Type.Object({
    orderId: Type.Number(),
    authorId: Type.Number(),
    productId: Type.Number(),
    quantity: Type.Number(),
    discount: Type.Number(),
    description: Type.Optional(Type.String()),
    sellPrice: Type.Optional(Type.String())
  });
  export type Marker = Static<typeof Obj>;
}

export namespace Update {
  export const Obj = Type.Object({
    quantity: Type.Optional(Type.Number()),
    discount: Type.Optional(Type.Number()),
    description: Type.Optional(Type.String()),
    sellPrice: Type.Optional(Type.String())
  })

  export type Marker = Static<typeof Obj>;
}

export namespace Find {
  export enum Filter {
    PRODUCT='PRODUCT',
    ORDER='ORDER'
  }
  export const Obj = Type.Intersect([
    Type.Object({
      type: Type.Enum(Filter),
      target: Type.Number()
    }),
    BaseFind.Obj
  ])

  export type Marker = Static<typeof Obj>;
}

