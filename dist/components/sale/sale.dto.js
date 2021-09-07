"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Find = exports.RemoveStockItemParam = exports.AddStockItem = exports.SealTransaction = exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var client_1 = require("@prisma/client");
var find_1 = require("@cend/commons/find");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        description: typebox_1.Type.Optional(typebox_1.Type.String()),
        authorId: typebox_1.Type.Number(),
        targetUserId: typebox_1.Type.Number(),
        createdAt: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time' }))
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        description: typebox_1.Type.Optional(typebox_1.Type.String()),
        tax: typebox_1.Type.Number(),
        discount: typebox_1.Type.Number(),
        shipping: typebox_1.Type.String(),
        targetUserId: typebox_1.Type.Number()
    });
})(Update = exports.Update || (exports.Update = {}));
var SealTransaction;
(function (SealTransaction) {
    SealTransaction.Obj = typebox_1.Type.Object({
        authorId: typebox_1.Type.Number(),
        nominal: typebox_1.Type.String(),
        status: typebox_1.Type.Enum(client_1.TransactionStatus),
        paymentMethod: typebox_1.Type.Enum(client_1.PaymentMethod),
        delay: typebox_1.Type.Optional(typebox_1.Type.Object({
            dueDate: typebox_1.Type.String({ format: 'date-time' })
        }))
    });
})(SealTransaction = exports.SealTransaction || (exports.SealTransaction = {}));
var AddStockItem;
(function (AddStockItem) {
    AddStockItem.Obj = typebox_1.Type.Object({
        authorId: typebox_1.Type.Number(),
        productId: typebox_1.Type.Number(),
        buyPrice: typebox_1.Type.Number(),
        sellPrice: typebox_1.Type.Number(),
        quantity: typebox_1.Type.Number(),
        available: typebox_1.Type.Number(),
        sold: typebox_1.Type.Number(),
        defect: typebox_1.Type.Number(),
        returned: typebox_1.Type.Number()
    });
})(AddStockItem = exports.AddStockItem || (exports.AddStockItem = {}));
var RemoveStockItemParam;
(function (RemoveStockItemParam) {
    RemoveStockItemParam.Obj = typebox_1.Type.Object({
        id: typebox_1.Type.Number(),
        stockItemId: typebox_1.Type.Number()
    });
})(RemoveStockItemParam = exports.RemoveStockItemParam || (exports.RemoveStockItemParam = {}));
var Find;
(function (Find) {
    Find.Obj = typebox_1.Type.Intersect([
        typebox_1.Type.Object({
            keyword: typebox_1.Type.String({ default: '' }),
            year: typebox_1.Type.Number(),
            month: typebox_1.Type.Number()
        }),
        find_1.FindOptions.Obj
    ]);
})(Find = exports.Find || (exports.Find = {}));
