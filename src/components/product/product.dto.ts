import { Static, Type } from '@sinclair/typebox'
import { ID } from '@cend/commons/request'

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
    unit: Type.String()
  })
  export type Marker = Static<typeof Obj>;
}
