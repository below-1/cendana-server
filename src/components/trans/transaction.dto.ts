import { Static, Type } from '@sinclair/typebox'
import { FindOptions as BaseFind } from '@cend/commons/find';
import { TransType } from './trans-type.enum'

export namespace Find {

  export const Obj = Type.Intersect([
    Type.Object({
      type: Type.Enum(TransType),
      keyword: Type.String({ default: '' }),
      year: Type.Number(),
      month: Type.Number()
    }),
    BaseFind.Obj
  ])

  export type Marker = Static<typeof Obj>;
}
