import { Static, Type } from '@sinclair/typebox'
import { TransactionStatus, PaymentMethod } from '@prisma/client'
import { FindOptions } from '@cend/commons/find';

export namespace Report1 {
  export const Obj = Type.Object({
    year: Type.Number(),
    month: Type.Number()
  })

  export type Marker = Static<typeof Obj>;
}
