import { Static, Type } from '@sinclair/typebox'
import { prisma } from '@cend/commons/prisma'
import { Role } from '@prisma/client'

export namespace Create {
  export const Obj = Type.Object({
    name: Type.String(),
    role: Type.Enum(Role),
    address: Type.Optional(Type.String()),
    mobile: Type.Optional(Type.String()),
    email: Type.Optional(Type.String())
  })
  export type Marker = Static<typeof Obj>;
}

export namespace Update {
  export const Obj = Type.Object({
    name: Type.Optional(Type.String()),
    address: Type.Optional(Type.String()),
    mobile: Type.Optional(Type.String()),
    email: Type.Optional(Type.String())
  })
  export type Marker = Static<typeof Obj>;
}

export namespace Customer {
  export namespace Create {
    export const Obj = Type.Object({
      name: Type.String(),
      address: Type.Optional(Type.String()),
      mobile: Type.Optional(Type.String()),
      email: Type.Optional(Type.String())
    })
    export type Marker = Static<typeof Obj>;
  }

  export namespace Update {
    export const Obj = Type.Object({
      name: Type.Optional(Type.String()),
      address: Type.Optional(Type.String()),
      mobile: Type.Optional(Type.String()),
      email: Type.Optional(Type.String())
    })
    export type Marker = Static<typeof Obj>;
  }
}

export namespace Supplier {
  export namespace Create {
    export const Obj = Type.Object({
      name: Type.String(),
      address: Type.String(),
      mobile: Type.String(),
      email: Type.Optional(Type.String())
    })
    export type Marker = Static<typeof Obj>;
  }

  export namespace Update {
    export const Obj = Type.Object({
      name: Type.Optional(Type.String()),
      address: Type.Optional(Type.String()),
      mobile: Type.Optional(Type.String()),
      email: Type.Optional(Type.String())
    })
    export type Marker = Static<typeof Obj>;
  }
}
