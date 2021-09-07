"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChangeDefect = exports.Find = exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var find_1 = require("@cend/commons/find");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        orderId: typebox_1.Type.Number(),
        authorId: typebox_1.Type.Number(),
        productId: typebox_1.Type.Number(),
        buyPrice: typebox_1.Type.Number(),
        sellPrice: typebox_1.Type.Number(),
        quantity: typebox_1.Type.Number(),
        available: typebox_1.Type.Number(),
        defect: typebox_1.Type.Number()
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        authorId: typebox_1.Type.Number(),
        buyPrice: typebox_1.Type.Number(),
        sellPrice: typebox_1.Type.Number(),
        quantity: typebox_1.Type.Number(),
        available: typebox_1.Type.Number(),
        sold: typebox_1.Type.Number(),
        defect: typebox_1.Type.Number(),
        returned: typebox_1.Type.Number()
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
var ChangeDefect;
(function (ChangeDefect) {
    ChangeDefect.Obj = typebox_1.Type.Object({
        defect: typebox_1.Type.Number({ minimum: 0 })
    });
})(ChangeDefect = exports.ChangeDefect || (exports.ChangeDefect = {}));
