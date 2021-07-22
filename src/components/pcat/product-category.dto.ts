import { Static, Type } from '@sinclair/typebox'

export namespace Create {
  export const Obj = Type.Object({
    title: Type.String(),
  })
  export type Marker = Static<typeof Obj>;
}

export namespace Update {
  export const Obj = Type.Object({
    title: Type.String(),
  });
  export type Marker = Static<typeof Obj>;
}
