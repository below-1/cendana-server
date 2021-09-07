"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var client_1 = require("@prisma/client");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        authorId: typebox_1.Type.Number(),
        nominal: typebox_1.Type.String(),
        createdAt: typebox_1.Type.String({ format: 'date-time' }),
        status: typebox_1.Type.Enum(client_1.TransactionStatus),
        paymentMethod: typebox_1.Type.Enum(client_1.PaymentMethod)
    });
})(Create = exports.Create || (exports.Create = {}));
