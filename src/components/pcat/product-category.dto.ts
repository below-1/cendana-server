import { Static, Type } from '@sinclair/typebox'
import { FindOptions } from '@cend/commons/find';

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

export namespace Find {
  export const Obj = Type.Intersect([
    Type.Object({
      keyword: Type.Optional(Type.String())
    }),
    FindOptions.Obj
  ]);
  export type Marker = Static<typeof Obj>;
}
