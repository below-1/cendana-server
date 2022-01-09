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
exports.checkSnapshot = exports.snapshot = void 0;
var prisma_1 = require("@cend/commons/prisma");
var date_fns_1 = require("date-fns");
function snapshot(target) {
    return __awaiter(this, void 0, void 0, function () {
        var t1, hpp, persediaan;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    t1 = date_fns_1.format(target, 'yyyy-MM-dd');
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select coalesce(sum(p.available * p.\"sellPrice\"), 0) as total from \"Product\" p")];
                case 1:
                    hpp = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select coalesce(sum(p.available * p.\"sellPrice\"), 0) as total from \"Product\" p")];
                case 2:
                    persediaan = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$executeRaw(templateObject_1 || (templateObject_1 = __makeTemplateObject(["delete from \"RecordProduct\" where \"date\" = ", ""], ["delete from \"RecordProduct\" where \"date\" = ", ""])), target)];
                case 3:
                    _a.sent();
                    return [4 /*yield*/, prisma_1.prisma.recordProduct.create({
                            data: {
                                date: target,
                                hpp: hpp ? hpp : 0,
                                persediaan: persediaan ? persediaan : 0
                            }
                        })];
                case 4:
                    _a.sent();
                    return [2 /*return*/];
            }
        });
    });
}
exports.snapshot = snapshot;
function checkSnapshot(target) {
    return __awaiter(this, void 0, void 0, function () {
        var total;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, prisma_1.prisma.recordProduct.count({
                        where: {
                            date: target
                        }
                    })];
                case 1:
                    total = _a.sent();
                    return [2 /*return*/, total > 0];
            }
        });
    });
}
exports.checkSnapshot = checkSnapshot;
var templateObject_1;
