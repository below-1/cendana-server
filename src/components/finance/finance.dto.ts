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

export namespace PerubahanModal {
  export const Obj = Type.Object({
    month: Type.Number(),
    year: Type.Number(),
    prive: Type.Number(),
    labaBersih: Type.Number()
  })
  export type Marker = Static<typeof Obj>
}

export namespace Neraca {
  export const Obj = Type.Object({
    month: Type.Number(),
    year: Type.Number(),
    
  })
}


export namespace Snapshot {
  export const Obj = Type.Object({
    target: Type.String({ format: 'date' })
  })
  export type Marker = Static<typeof Obj>
}

export namespace CreateReport {
  export const Obj = Type.Object({
    month: Type.Number(),
    year: Type.Number(),
    pajak: Type.String()
  })
  export type Marker = Static<typeof Obj>
}

export namespace FindReport {
  export const Obj = Type.Object({
    month: Type.Number(),
    year: Type.Number()
  })
  export type Marker = Static<typeof Obj>
}