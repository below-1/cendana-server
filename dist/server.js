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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.createServer = void 0;
var fastify_1 = __importDefault(require("fastify"));
var fastify_blipp_1 = __importDefault(require("fastify-blipp"));
var fastify_cors_1 = __importDefault(require("fastify-cors"));
var fastify_swagger_1 = __importDefault(require("fastify-swagger"));
var components = __importStar(require("@cend/components"));
function createServer() {
    var server = fastify_1.default({
        logger: process.env.NODE_ENV == 'development'
    });
    server.register(fastify_cors_1.default);
    server.register(fastify_blipp_1.default);
    server.register(fastify_swagger_1.default, {
        routePrefix: '/documentation',
        exposeRoute: true,
        swagger: {
            info: {
                title: 'Cendana API',
                version: '1.0.0'
            },
            tags: [
                { name: 'product-categories', description: "Product Categories' Product Endpoints" },
                { name: 'products', description: "Product's Endpoints" }
            ]
        }
    });
    // server.register(prisma)
    server.register(components.auth.plugin, { prefix: '/auth' });
    server.register(components.productCategory.plugin, { prefix: '/v1/api/product-categories' });
    server.register(components.product.plugin, { prefix: '/v1/api/products' });
    server.register(components.user.plugin, { prefix: '/v1/api/users' });
    server.register(components.purchase.plugin, { prefix: '/v1/api/purchases' });
    server.register(components.stockItem.plugin, { prefix: '/v1/api/stock-items' });
    server.register(components.sale.plugin, { prefix: '/v1/api/sales' });
    server.register(components.orderItem.plugin, { prefix: '/v1/api/order-items' });
    server.register(components.delay.plugin, { prefix: '/v1/api/delays' });
    server.register(components.opex.plugin, { prefix: '/v1/api/opexes' });
    server.register(components.opexTrans.plugin, { prefix: '/v1/api/opex-trans' });
    server.register(components.tool.plugin, { prefix: '/v1/api/tools' });
    server.register(components.toolTrans.plugin, { prefix: '/v1/api/tool-trans' });
    server.register(components.transaction.plugin, { prefix: '/v1/api/transactions' });
    server.register(components.latestStock.plugin, { prefix: '/v1/api/latest-stock' });
    server.register(components.summary.plugin, { prefix: '/v1/api/summary' });
    server.register(components.finance.plugin, { prefix: '/v1/api/finance' });
    return server;
}
exports.createServer = createServer;
