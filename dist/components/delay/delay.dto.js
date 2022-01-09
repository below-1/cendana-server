"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.DueToday = exports.Find = void 0;
var typebox_1 = require("@sinclair/typebox");
var client_1 = require("@prisma/client");
var find_1 = require("@cend/commons/find");
var Find;
(function (Find) {
    Find.Obj = typebox_1.Type.Intersect([
        typebox_1.Type.Object({
            complete: typebox_1.Type.Optional(typebox_1.Type.Boolean({ default: false })),
            type: typebox_1.Type.Optional(typebox_1.Type.Enum(client_1.DelayType))
        }),
        find_1.FindOptions.Obj
    ]);
})(Find = exports.Find || (exports.Find = {}));
var DueToday;
(function (DueToday) {
    DueToday.Obj = typebox_1.Type.Object({
        kind: typebox_1.Type.Union([typebox_1.Type.Literal('PAYABLE'), typebox_1.Type.Literal('RECEIVABLE'), typebox_1.Type.Literal('ALL')])
    });
})(DueToday = exports.DueToday || (exports.DueToday = {}));
