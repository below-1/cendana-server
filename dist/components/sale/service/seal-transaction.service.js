"use strict";
var __makeTemplateObject = (this && this.__makeTemplateObject) || function (cooked, raw) {
    if (Object.defineProperty) { Object.defineProperty(cooked, "raw", { value: raw }); } else { cooked.raw = raw; }
    return cooked;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.sealTransaction = void 0;
var prisma_1 = require("@cend/commons/prisma");
var client_1 = require("@prisma/client");
var runtime_1 = require("@prisma/client/runtime");
function sealTransaction(payload) {
    return __awaiter(this, void 0, void 0, function () {
        var orderId, order, orderItems, statements, _i, orderItems_1, orderItem, requestedQuantity, productId, remainder, syncProduct, sealOrderStatement, createTransStatement, decimalNominal, createDelayStatement;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    orderId = payload.orderId;
                    return [4 /*yield*/, prisma_1.prisma.order.findFirst({
                            where: { AND: [
                                    { id: orderId },
                                    { orderType: client_1.OrderType.SALE }
                                ] },
                            include: {
                                orderItems: true
                            }
                        })];
                case 1:
                    order = _a.sent();
                    if (!order) {
                        throw new Error("can't find sale with id=" + orderId);
                    }
                    orderItems = order.orderItems;
                    statements = [];
                    for (_i = 0, orderItems_1 = orderItems; _i < orderItems_1.length; _i++) {
                        orderItem = orderItems_1[_i];
                        requestedQuantity = orderItem.quantity, productId = orderItem.productId;
                        remainder = requestedQuantity;
                        syncProduct = prisma_1.prisma.$executeRaw(templateObject_1 || (templateObject_1 = __makeTemplateObject(["\n      update \"Product\" set \n        available = available - ", ",\n        sold = sold + ", "\n        where id = ", ""], ["\n      update \"Product\" set \n        available = available - ", ",\n        sold = sold + ", "\n        where id = ", ""])), orderItem.quantity, orderItem.quantity, orderItem.productId);
                        statements.push(syncProduct);
                    }
                    sealOrderStatement = prisma_1.prisma.order.update({
                        where: {
                            id: orderId
                        },
                        data: {
                            orderStatus: client_1.OrderStatus.SEALED
                        }
                    });
                    statements.push(sealOrderStatement);
                    createTransStatement = prisma_1.prisma.transaction.create({
                        data: {
                            orderId: orderId,
                            authorId: payload.authorId,
                            type: client_1.TransactionType.DEBIT,
                            status: payload.status,
                            paymentMethod: payload.paymentMethod,
                            nominal: payload.nominal,
                            createdAt: order.createdAt
                        }
                    });
                    statements.push(createTransStatement);
                    decimalNominal = new runtime_1.Decimal(payload.nominal);
                    if (decimalNominal.lessThan(order.grandTotal)) {
                        if (!payload.delay) {
                            throw new Error("Due Date of payment is not provided");
                        }
                        createDelayStatement = prisma_1.prisma.delay.create({
                            data: {
                                authorId: payload.authorId,
                                type: client_1.DelayType.RECEIVABLE,
                                orderId: orderId,
                                dueDate: new Date(payload.delay.dueDate),
                                total: order.grandTotal.sub(decimalNominal).toString(),
                                complete: false
                            }
                        });
                        statements.push(createDelayStatement);
                    }
                    return [4 /*yield*/, prisma_1.prisma.$transaction(statements)];
                case 2:
                    _a.sent();
                    return [2 /*return*/, order];
            }
        });
    });
}
exports.sealTransaction = sealTransaction;
var templateObject_1;
