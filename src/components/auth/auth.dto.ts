import { Static, Type } from '@sinclair/typebox'

export namespace Login {
  export const Obj = Type.Object({
    username: Type.String(),
    password: Type.String()
  })
  export type Marker = Static<typeof Obj>;
}

export namespace SignUp {
  export const Obj = Type.Object({
    username: Type.String(),
    password: Type.String(),
    name: Type.String()
  })
  export type Marker = Static<typeof Obj>;
}
