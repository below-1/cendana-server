"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Find = exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var client_1 = require("@prisma/client");
var find_1 = require("@cend/commons/find");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        nominal: typebox_1.Type.Number(),
        createdAt: typebox_1.Type.Optional(typebox_1.Type.String({ format: 'date-time' })),
        authorId: typebox_1.Type.Number(),
        targetUserId: typebox_1.Type.Number(),
        status: typebox_1.Type.Enum(client_1.TransactionStatus),
        paymentMethod: typebox_1.Type.Enum(client_1.PaymentMethod)
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        nominal: typebox_1.Type.Number(),
        authorId: typebox_1.Type.Number(),
        targetUserId: typebox_1.Type.Number(),
        status: typebox_1.Type.Enum(client_1.TransactionStatus),
        paymentMethod: typebox_1.Type.Enum(client_1.PaymentMethod)
    });
})(Update = exports.Update || (exports.Update = {}));
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
