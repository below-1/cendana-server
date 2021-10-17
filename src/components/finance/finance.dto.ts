import { Static, Type } from '@sinclair/typebox';

export namespace LabaRugi {
  export const Obj = Type.Object({
    month: Type.Number(),
    year: Type.Number()
  })
  export type Marker = Static<typeof Obj>
}
