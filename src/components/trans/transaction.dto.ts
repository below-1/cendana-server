import { Static, Type } from '@sinclair/typebox'
import { FindOptions as BaseFind } from '@cend/commons/find';

export namespace Find {

  enum TransType {
    PURCHASE = 'PURCHASE',
    SALE = 'SALE',
    OPEX = 'OPEX',
    ALL = 'ALL'
  }

  export const Obj = Type.Intersect([
    Type.Object({
      type: Type.Enum(TransType)
    }),
    BaseFind.Obj
  ])

  export type Marker = Static<typeof Obj>;
}
