"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Find = exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var find_1 = require("@cend/commons/find");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        orderId: typebox_1.Type.Number(),
        authorId: typebox_1.Type.Number(),
        productId: typebox_1.Type.Number(),
        quantity: typebox_1.Type.Number(),
        discount: typebox_1.Type.Number(),
        description: typebox_1.Type.Optional(typebox_1.Type.String()),
        sellPrice: typebox_1.Type.Optional(typebox_1.Type.String())
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        quantity: typebox_1.Type.Optional(typebox_1.Type.Number()),
        discount: typebox_1.Type.Optional(typebox_1.Type.Number()),
        description: typebox_1.Type.Optional(typebox_1.Type.String()),
        sellPrice: typebox_1.Type.Optional(typebox_1.Type.String())
    });
})(Update = exports.Update || (exports.Update = {}));
var Find;
(function (Find) {
    var Filter;
    (function (Filter) {
        Filter["PRODUCT"] = "PRODUCT";
        Filter["ORDER"] = "ORDER";
    })(Filter = Find.Filter || (Find.Filter = {}));
    Find.Obj = typebox_1.Type.Intersect([
        typebox_1.Type.Object({
            type: typebox_1.Type.Enum(Filter),
            target: typebox_1.Type.Number()
        }),
        find_1.FindOptions.Obj
    ]);
})(Find = exports.Find || (exports.Find = {}));
