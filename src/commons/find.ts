import { Static, Type } from '@sinclair/typebox'

export namespace FindOptions {
  export const Obj = Type.Object({
    page: Type.Number({ default: 0 }),
    perPage: Type.Number({ default: -1 })
  })
  export type Marker = Static<typeof Obj>;
}

export interface FindResult<T> {
  totalPage: number;
  totalData: number;
  items: T[];
}

// export interface FindOptions {
//   skip: number;
//   take: number;
//   lastId: number;
// }
