import { Static, Type } from '@sinclair/typebox'

export namespace ID {
  export const Obj = Type.Object({
    id: Type.Integer(),
  })
  export type Marker = Static<typeof Obj>;
}
