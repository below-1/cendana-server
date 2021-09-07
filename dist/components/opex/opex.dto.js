"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RemoveTransaction = exports.AddTransaction = exports.Find = exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var client_1 = require("@prisma/client");
var find_1 = require("@cend/commons/find");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        title: typebox_1.Type.String(),
        // authorId: Type.Number(),
        // nominal: Type.String(),
        // status: Type.Enum(TransactionStatus),
        // paymentMethod: Type.Enum(PaymentMethod)
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        title: typebox_1.Type.String(),
        // nominal: Type.String(),
        // status: Type.Enum(TransactionStatus),
        // paymentMethod: Type.Enum(PaymentMethod)
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
var AddTransaction;
(function (AddTransaction) {
    AddTransaction.Obj = typebox_1.Type.Object({
        authorId: typebox_1.Type.Number(),
        nominal: typebox_1.Type.String(),
        status: typebox_1.Type.Enum(client_1.TransactionStatus),
        paymentMethod: typebox_1.Type.Enum(client_1.PaymentMethod),
        createdAt: typebox_1.Type.String({ format: 'date-time' })
    });
})(AddTransaction = exports.AddTransaction || (exports.AddTransaction = {}));
var RemoveTransaction;
(function (RemoveTransaction) {
    RemoveTransaction.Obj = typebox_1.Type.Object({
        id: typebox_1.Type.Number(),
        transactionId: typebox_1.Type.Number()
    });
})(RemoveTransaction = exports.RemoveTransaction || (exports.RemoveTransaction = {}));
