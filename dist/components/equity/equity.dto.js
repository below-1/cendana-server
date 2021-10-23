"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var client_1 = require("@prisma/client");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        user: typebox_1.Type.String(),
        nominal: typebox_1.Type.String(),
        authorId: typebox_1.Type.Number(),
        createdAt: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time' })),
        status: typebox_1.Type.Enum(client_1.TransactionStatus),
        paymentMethod: typebox_1.Type.Enum(client_1.PaymentMethod),
        type: typebox_1.Type.Enum(client_1.TransactionType)
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        user: typebox_1.Type.String(),
        nominal: typebox_1.Type.String(),
        authorId: typebox_1.Type.Number(),
        createdAt: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time' })),
        status: typebox_1.Type.Enum(client_1.TransactionStatus),
        paymentMethod: typebox_1.Type.Enum(client_1.PaymentMethod),
        type: typebox_1.Type.Enum(client_1.TransactionType)
    });
})(Update = exports.Update || (exports.Update = {}));
