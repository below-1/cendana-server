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
exports.plugin = void 0;
var CustomerHandlers = __importStar(require("./customer.handler"));
var SupplierHandlers = __importStar(require("./supplier.handler"));
var StafHandlers = __importStar(require("./staf.handler"));
var AdminHandlers = __importStar(require("./admin.handler"));
var DTO = __importStar(require("./user.dto"));
var request_1 = require("@cend/commons/request");
function plugin(fastify) {
    return __awaiter(this, void 0, void 0, function () {
        return __generator(this, function (_a) {
            fastify.post('/stafs', {
                schema: {
                    tags: ['stafs'],
                    body: DTO.Staf.Create.Obj
                },
                handler: StafHandlers.post
            });
            fastify.put('/stafs/:id', {
                schema: {
                    tags: ['stafs'],
                    params: request_1.ID.Obj,
                    body: DTO.Staf.Update.Obj
                },
                handler: StafHandlers.put
            });
            fastify.delete('/stafs/:id', {
                schema: {
                    tags: ['stafs'],
                    params: request_1.ID.Obj
                },
                handler: StafHandlers.remove
            });
            fastify.get('/stafs', {
                schema: {
                    tags: ['stafs'],
                    querystring: DTO.Find.Obj
                },
                handler: StafHandlers.getMany
            });
            fastify.get('/stafs/:id', {
                schema: {
                    tags: ['stafs'],
                    params: request_1.ID.Obj
                },
                handler: CustomerHandlers.getOne
            });
            fastify.post('/customers', {
                schema: {
                    tags: ['customers'],
                    body: DTO.Customer.Create.Obj
                },
                handler: CustomerHandlers.post
            });
            fastify.put('/customers/:id', {
                schema: {
                    tags: ['customers'],
                    params: request_1.ID.Obj,
                    body: DTO.Customer.Update.Obj
                },
                handler: CustomerHandlers.put
            });
            fastify.delete('/customers/:id', {
                schema: {
                    tags: ['customers'],
                    params: request_1.ID.Obj
                },
                handler: CustomerHandlers.remove
            });
            fastify.get('/customers', {
                schema: {
                    tags: ['customers'],
                    querystring: DTO.Find.Obj
                },
                handler: CustomerHandlers.getMany
            });
            fastify.get('/customers/:id', {
                schema: {
                    tags: ['customers'],
                    params: request_1.ID.Obj
                },
                handler: CustomerHandlers.getOne
            });
            fastify.post('/suppliers', {
                schema: {
                    tags: ['suppliers'],
                    body: DTO.Supplier.Create.Obj
                },
                handler: SupplierHandlers.post
            });
            fastify.get('/suppliers', {
                schema: {
                    tags: ['suppliers'],
                    querystring: DTO.Find.Obj
                },
                handler: SupplierHandlers.getMany
            });
            fastify.get('/suppliers/:id', {
                schema: {
                    tags: ['suppliers'],
                    params: request_1.ID.Obj
                },
                handler: SupplierHandlers.getOne
            });
            fastify.put('/suppliers/:id', {
                schema: {
                    tags: ['suppliers'],
                    params: request_1.ID.Obj,
                    body: DTO.Supplier.Update.Obj
                },
                handler: SupplierHandlers.put
            });
            fastify.delete('/suppliers/:id', {
                schema: {
                    tags: ['suppliers'],
                    params: request_1.ID.Obj
                },
                handler: SupplierHandlers.remove
            });
            fastify.get('/admins', {
                schema: {
                    tags: ['admins'],
                    querystring: DTO.Find.Obj
                },
                handler: AdminHandlers.getMany
            });
            fastify.delete('/admins/:id', {
                schema: {
                    tags: ['admins'],
                    params: request_1.ID.Obj
                },
                handler: AdminHandlers.remove
            });
            return [2 /*return*/];
        });
    });
}
exports.plugin = plugin;
