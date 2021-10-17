import { Static, Type } from '@sinclair/typebox';

export enum RespTypeEnum {
  JSON = 'JSON',
  WORD = 'WORD'
}

export namespace RespType {
  export const Obj = Type.Object({
    type: Type.Enum(RespTypeEnum)
  })
  export type Marker = Static<typeof Obj>
}

export namespace LabaRugi {
  export const Obj = Type.Object({
    month: Type.Number(),
    year: Type.Number(),
    pajak: Type.Number()
  })
  export type Marker = Static<typeof Obj>
}
