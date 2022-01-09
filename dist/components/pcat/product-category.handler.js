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
exports.findOne = exports.find = exports.remove = exports.put = exports.post = void 0;
var service_1 = require("./service");
function post(request, reply) {
    return __awaiter(this, void 0, void 0, function () {
        var result;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, service_1.create(request.body)];
                case 1:
                    result = _a.sent();
                    reply.send(result);
                    return [2 /*return*/];
            }
        });
    });
}
exports.post = post;
function put(request, reply) {
    return __awaiter(this, void 0, void 0, function () {
        var id, payload, result;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    id = request.params.id;
                    payload = request.body;
                    return [4 /*yield*/, service_1.update(id, payload)];
                case 1:
                    result = _a.sent();
                    reply.send(result);
                    return [2 /*return*/];
            }
        });
    });
}
exports.put = put;
function remove(request, reply) {
    return __awaiter(this, void 0, void 0, function () {
        var id, result;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    id = request.params.id;
                    return [4 /*yield*/, service_1.remove(id)];
                case 1:
                    result = _a.sent();
                    reply.send(result);
                    return [2 /*return*/];
            }
        });
    });
}
exports.remove = remove;
function find(request, reply) {
    return __awaiter(this, void 0, void 0, function () {
        var _a, keyword, options, _keyword, result;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0:
                    _a = request.query, keyword = _a.keyword, options = __rest(_a, ["keyword"]);
                    _keyword = keyword ? keyword : '';
                    return [4 /*yield*/, service_1.find(_keyword, options)];
                case 1:
                    result = _b.sent();
                    reply.send(result);
                    return [2 /*return*/];
            }
        });
    });
}
exports.find = find;
function findOne(request, reply) {
    return __awaiter(this, void 0, void 0, function () {
        var productCategory;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, service_1.findOne(request.params.id)];
                case 1:
                    productCategory = _a.sent();
                    if (!productCategory) {
                        throw new Error("can't find ProductCategory(id=" + request.params.id + ")");
                    }
                    reply.send(productCategory);
                    return [2 /*return*/];
            }
        });
    });
}
exports.findOne = findOne;
