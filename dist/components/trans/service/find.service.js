"use strict";
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
var __spreadArray = (this && this.__spreadArray) || function (to, from) {
    for (var i = 0, il = from.length, j = to.length; i < il; i++, j++)
        to[j] = from[i];
    return to;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.findTransactions = void 0;
var prisma_1 = require("@cend/commons/prisma");
var client_1 = require("@prisma/client");
var trans_type_enum_1 = require("../trans-type.enum");
var to_date_upper_lower_1 = require("@cend/commons/to-date-upper-lower");
function findTransactions(t, options) {
    return __awaiter(this, void 0, void 0, function () {
        var conditions, month, year, _a, lowerDate, upperDate, where, totalData, perPage, totalPage, offset, items;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0:
                    conditions = [];
                    month = options.month, year = options.year;
                    _a = to_date_upper_lower_1.toDateUpperLower(year, month), lowerDate = _a.lower, upperDate = _a.upper;
                    conditions.push({ createdAt: {
                            gte: lowerDate,
                            lte: upperDate
                        } });
                    switch (t) {
                        case trans_type_enum_1.TransType.PURCHASE:
                            conditions = __spreadArray(__spreadArray([], conditions), [
                                { orderId: { gte: 1 } },
                                { type: client_1.TransactionType.CREDIT }
                            ]);
                            break;
                        case trans_type_enum_1.TransType.SALE:
                            conditions = __spreadArray(__spreadArray([], conditions), [
                                { orderId: { gte: 1 } },
                                { type: client_1.TransactionType.DEBIT }
                            ]);
                            break;
                        case trans_type_enum_1.TransType.OPEX:
                            conditions = __spreadArray(__spreadArray([], conditions), [
                                { opex: { title: { contains: options.keyword } } },
                                { type: client_1.TransactionType.CREDIT }
                            ]);
                            break;
                        case trans_type_enum_1.TransType.TOOL:
                            conditions = __spreadArray(__spreadArray([], conditions), [
                                { tool: { title: { contains: options.keyword } } },
                                { type: client_1.TransactionType.CREDIT }
                            ]);
                            break;
                        case trans_type_enum_1.TransType.AP_PAYMENT:
                            conditions = __spreadArray(__spreadArray([], conditions), [
                                { delay: { type: client_1.DelayType.PAYABLE } }
                            ]);
                            break;
                        case trans_type_enum_1.TransType.AR_PAYMENT:
                            conditions = __spreadArray(__spreadArray([], conditions), [
                                { delay: { type: client_1.DelayType.RECEIVABLE } }
                            ]);
                            break;
                        case trans_type_enum_1.TransType.EQUITY_CHANGE:
                            conditions = __spreadArray(__spreadArray([], conditions), [
                                { equityChangeId: { gte: 1 } }
                            ]);
                            break;
                        case trans_type_enum_1.TransType.ALL:
                            break;
                        default:
                            throw new Error('unknown t');
                    }
                    where = {
                        AND: conditions
                    };
                    return [4 /*yield*/, prisma_1.prisma.transaction.count({
                            where: where
                        })];
                case 1:
                    totalData = _b.sent();
                    perPage = options.perPage == -1 ? totalData : options.perPage;
                    totalPage = Math.ceil(totalData / perPage);
                    offset = perPage * options.page;
                    return [4 /*yield*/, prisma_1.prisma.transaction.findMany({
                            where: where,
                            include: {
                                opex: true,
                                tool: true,
                                order: true,
                                author: true,
                                equityChange: true
                            },
                            orderBy: {
                                createdAt: 'desc'
                            },
                            take: perPage,
                            skip: offset
                        })];
                case 2:
                    items = _b.sent();
                    return [2 /*return*/, {
                            totalPage: totalPage,
                            totalData: totalData,
                            items: items
                        }];
            }
        });
    });
}
exports.findTransactions = findTransactions;
