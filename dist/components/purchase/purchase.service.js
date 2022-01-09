"use strict";
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
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
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.sealTransaction = exports.getCurrentPurchaseTotals = exports.calculatePurchaseTotals = exports.updateStock = exports.create = void 0;
var client_1 = require("@prisma/client");
var prisma_1 = require("@cend/commons/prisma");
var runtime_1 = require("@prisma/client/runtime");
var stock_item_view_1 = require("../sitem/stock-item.view");
var purchase_view_1 = require("./purchase.view");
var productServices = __importStar(require("../product/product.service"));
var trans_1 = require("../trans");
var delay_1 = require("../delay");
function create(payload) {
    return __awaiter(this, void 0, void 0, function () {
        var authorId, targetUserId, rest, purchase;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    authorId = payload.authorId, targetUserId = payload.targetUserId, rest = __rest(payload, ["authorId", "targetUserId"]);
                    return [4 /*yield*/, prisma_1.prisma.order.create({
                            data: __assign(__assign({}, rest), { 
                                // Initial value for some fields
                                grandTotal: 0, subTotal: 0, tax: 0, shipping: 0, discount: 0, orderStatus: client_1.OrderStatus.OPEN, orderType: client_1.OrderType.BUY, author: {
                                    connect: { id: authorId }
                                }, targetUser: {
                                    connect: { id: targetUserId }
                                } })
                        })];
                case 1:
                    purchase = _a.sent();
                    return [2 /*return*/, purchase];
            }
        });
    });
}
exports.create = create;
function updateStock(orderId) {
    return __awaiter(this, void 0, void 0, function () {
        var purchase, stockItems, totals, result;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, purchase_view_1.findPurchaseById(orderId)];
                case 1:
                    purchase = _a.sent();
                    return [4 /*yield*/, stock_item_view_1.findForOrder(orderId)];
                case 2:
                    stockItems = _a.sent();
                    totals = calculatePurchaseTotals(purchase, stockItems);
                    return [4 /*yield*/, prisma_1.prisma.order.update({
                            where: {
                                id: orderId
                            },
                            data: {
                                grandTotal: totals.grandTotal,
                                subTotal: totals.subTotal,
                                total: totals.total
                            }
                        })];
                case 3:
                    result = _a.sent();
                    return [2 /*return*/, result];
            }
        });
    });
}
exports.updateStock = updateStock;
function calculatePurchaseTotals(order, stockItems) {
    // SUB_TOTAL
    var subTotal = stockItems
        .map(function (x) { return x.buyPrice.mul(x.quantity); })
        .reduce(function (a, b) { return a.plus(b); }, new runtime_1.Decimal('0'));
    var totalPlusShipping = subTotal.plus(order.shipping);
    var totalPlusShippingAndTax = totalPlusShipping.plus(totalPlusShipping.mul(order.tax));
    // TOTAL
    var total = totalPlusShippingAndTax;
    var itemsDiscountedTotal = stockItems
        .map(function (si) {
        var totalItemPrice = si.buyPrice.mul(si.quantity);
        var discountedTotalItemPrice = totalItemPrice.mul(si.discount);
        var totalMinusDiscount = totalItemPrice.sub(discountedTotalItemPrice);
        return totalMinusDiscount;
    })
        .reduce(function (a, b) { return a.plus(b); }, new runtime_1.Decimal('0'));
    var taxedItemsDiscounted = itemsDiscountedTotal.sub(itemsDiscountedTotal.mul(order.tax));
    var itemsDiscountedPlusShipping = taxedItemsDiscounted.plus(order.shipping);
    // GRAND TOTAL
    var grandTotal = itemsDiscountedPlusShipping;
    return {
        total: total,
        subTotal: subTotal,
        grandTotal: grandTotal
    };
}
exports.calculatePurchaseTotals = calculatePurchaseTotals;
function getCurrentPurchaseTotals(orderId) {
    return __awaiter(this, void 0, void 0, function () {
        var order, stockItems, allTotals;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, prisma_1.prisma.order.findFirst({ where: { id: orderId } })];
                case 1:
                    order = _a.sent();
                    if (!order) {
                        throw new Error("can't find order with id=" + orderId);
                    }
                    return [4 /*yield*/, prisma_1.prisma.order
                            .findFirst({ where: { id: orderId } })
                            .stockItems()];
                case 2:
                    stockItems = _a.sent();
                    allTotals = calculatePurchaseTotals(order, stockItems);
                    return [2 /*return*/, allTotals];
            }
        });
    });
}
exports.getCurrentPurchaseTotals = getCurrentPurchaseTotals;
function sealTransaction(orderId, payload) {
    return __awaiter(this, void 0, void 0, function () {
        var order, stockItems, _i, stockItems_1, stockItem, transStatements, result, transaction;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, prisma_1.prisma.order.findFirst({
                        where: { AND: [
                                { id: orderId },
                                { orderType: client_1.OrderType.BUY }
                            ] }
                    })];
                case 1:
                    order = _a.sent();
                    if (!order) {
                        throw new Error("can't find purchase with id=" + orderId);
                    }
                    return [4 /*yield*/, stock_item_view_1.findForOrder(orderId)];
                case 2:
                    stockItems = _a.sent();
                    _i = 0, stockItems_1 = stockItems;
                    _a.label = 3;
                case 3:
                    if (!(_i < stockItems_1.length)) return [3 /*break*/, 6];
                    stockItem = stockItems_1[_i];
                    return [4 /*yield*/, productServices.updateStocks(stockItem.productId)];
                case 4:
                    _a.sent();
                    _a.label = 5;
                case 5:
                    _i++;
                    return [3 /*break*/, 3];
                case 6:
                    transStatements = [];
                    return [4 /*yield*/, prisma_1.prisma.order.update({
                            where: {
                                id: orderId
                            },
                            data: {
                                orderStatus: client_1.OrderStatus.SEALED
                            }
                        })];
                case 7:
                    result = _a.sent();
                    return [4 /*yield*/, trans_1.repo.create({
                            orderId: result.id,
                            authorId: payload.authorId,
                            type: client_1.TransactionType.CREDIT,
                            status: payload.status,
                            paymentMethod: payload.paymentMethod,
                            nominal: payload.nominal
                        })];
                case 8:
                    transaction = _a.sent();
                    if (!transaction.nominal.lessThan(order.grandTotal)) return [3 /*break*/, 10];
                    if (!payload.delay) {
                        throw new Error("Due Date of payment is not provided");
                    }
                    return [4 /*yield*/, delay_1.delayRepo.create({
                            authorId: payload.authorId,
                            type: client_1.DelayType.PAYABLE,
                            orderId: orderId,
                            dueDate: new Date(payload.delay.dueDate),
                            total: order.grandTotal.sub(transaction.nominal).toString()
                        })];
                case 9:
                    _a.sent();
                    _a.label = 10;
                case 10: return [2 /*return*/, result];
            }
        });
    });
}
exports.sealTransaction = sealTransaction;
