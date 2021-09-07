"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FindFreeForOrder = exports.Find = exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var find_1 = require("@cend/commons/find");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        name: typebox_1.Type.String(),
        unit: typebox_1.Type.String(),
        categories: typebox_1.Type.Array(typebox_1.Type.Object({
            id: typebox_1.Type.Number()
        }))
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        name: typebox_1.Type.String(),
        unit: typebox_1.Type.String(),
        sellPrice: typebox_1.Type.Optional(typebox_1.Type.String()),
        categories: typebox_1.Type.Array(typebox_1.Type.Object({
            id: typebox_1.Type.Number()
        }))
    });
})(Update = exports.Update || (exports.Update = {}));
var Find;
(function (Find) {
    Find.Obj = typebox_1.Type.Intersect([
        typebox_1.Type.Object({
            keyword: typebox_1.Type.String({ default: '' })
        }),
        find_1.FindOptions.Obj
    ]);
})(Find = exports.Find || (exports.Find = {}));
var FindFreeForOrder;
(function (FindFreeForOrder) {
    FindFreeForOrder.Obj = typebox_1.Type.Intersect([
        typebox_1.Type.Object({
            orderId: typebox_1.Type.Number(),
            keyword: typebox_1.Type.String({ default: '' })
        }),
        find_1.FindOptions.Obj
    ]);
})(FindFreeForOrder = exports.FindFreeForOrder || (exports.FindFreeForOrder = {}));
