"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Find = void 0;
var typebox_1 = require("@sinclair/typebox");
var find_1 = require("@cend/commons/find");
var trans_type_enum_1 = require("./trans-type.enum");
var Find;
(function (Find) {
    Find.Obj = typebox_1.Type.Intersect([
        typebox_1.Type.Object({
            type: typebox_1.Type.Enum(trans_type_enum_1.TransType),
            keyword: typebox_1.Type.String({ default: '' }),
            year: typebox_1.Type.Number(),
            month: typebox_1.Type.Number()
        }),
        find_1.FindOptions.Obj
    ]);
})(Find = exports.Find || (exports.Find = {}));
