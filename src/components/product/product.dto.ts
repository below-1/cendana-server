import { Static, Type } from '@sinclair/typebox'
import { ID } from '@cend/commons/request'
import { FindOptions } from '@cend/commons/find';

export namespace Create {
  export const Obj = Type.Object({
    name: Type.String(),
    unit: Type.String(),
    categories: Type.Array(Type.Object({
      id: Type.Number()
    }))
  })
  export type Marker = Static<typeof Obj>;
}

export namespace Update {
  export const Obj = Type.Object({
    name: Type.String(),
    unit: Type.String(),
    sellPrice: Type.Optional(Type.String()),
    categories: Type.Array(Type.Object({
      id: Type.Number()
    }))
  })
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
