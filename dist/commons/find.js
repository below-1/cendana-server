"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FindOptions = void 0;
var typebox_1 = require("@sinclair/typebox");
var FindOptions;
(function (FindOptions) {
    FindOptions.Obj = typebox_1.Type.Object({
        page: typebox_1.Type.Number({ default: 0 }),
        perPage: typebox_1.Type.Number({ default: -1 })
    });
})(FindOptions = exports.FindOptions || (exports.FindOptions = {}));
// export interface FindOptions {
//   skip: number;
//   take: number;
//   lastId: number;
// }
