"use strict";
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
Object.defineProperty(exports, "__esModule", { value: true });
exports.printSales = void 0;
var prisma_1 = require("@cend/commons/prisma");
var client_1 = require("@prisma/client");
var to_date_upper_lower_1 = require("@cend/commons/to-date-upper-lower");
var csv = __importStar(require("fast-csv"));
function printSales(options) {
    return __awaiter(this, void 0, void 0, function () {
        var month, year, _a, lowerDate, upperDate, sales, items, lastTanggal, lastKode, lastCustomerName, _i, sales_1, sale, oiIndex, saleKode, tanggal, _b, _c, oi, item, csvStream;
        return __generator(this, function (_d) {
            switch (_d.label) {
                case 0:
                    month = options.month, year = options.year;
                    _a = to_date_upper_lower_1.toDateUpperLower(year, month), lowerDate = _a.lower, upperDate = _a.upper;
                    return [4 /*yield*/, prisma_1.prisma.order.findMany({
                            where: {
                                AND: [
                                    { orderType: client_1.OrderType.SALE },
                                    { createdAt: {
                                            gte: lowerDate,
                                            lte: upperDate
                                        } }
                                ],
                            },
                            orderBy: {
                                createdAt: 'desc'
                            },
                            include: {
                                transaction: true,
                                targetUser: true,
                                orderItems: {
                                    include: {
                                        product: true
                                    }
                                }
                            }
                        })];
                case 1:
                    sales = _d.sent();
                    items = [];
                    lastTanggal = null;
                    lastKode = null;
                    lastCustomerName = null;
                    for (_i = 0, sales_1 = sales; _i < sales_1.length; _i++) {
                        sale = sales_1[_i];
                        oiIndex = 0;
                        saleKode = sale.id;
                        tanggal = void 0;
                        if (lastTanggal != sale.createdAt) {
                            lastTanggal = sale.createdAt;
                            tanggal = lastTanggal.toISOString();
                        }
                        else {
                            tanggal = '';
                        }
                        for (_b = 0, _c = sale.orderItems; _b < _c.length; _b++) {
                            oi = _c[_b];
                            item = {};
                            item.itemName = oi.product.name;
                            item.itemQuantity = oi.quantity;
                            item.itemSellPrice = oi.sellPrice.toFixed(2);
                            item.item_harga_x_qty = oi.sellPrice.mul(oi.quantity).toFixed(2);
                            if (oiIndex == 0) {
                                item.tanggal = tanggal;
                                item.kode = sale.id;
                                item.customerName = sale.targetUser.name;
                                item.customerAddress = sale.targetUser.address;
                            }
                            items.push(item);
                            oiIndex += 1;
                        }
                    }
                    csvStream = csv.format({ headers: true });
                    items.forEach(function (item) {
                        csvStream.write(item);
                    });
                    csvStream.end();
                    return [2 /*return*/, csvStream];
            }
        });
    });
}
exports.printSales = printSales;
