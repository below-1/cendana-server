"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.prisma = void 0;
var client_1 = require("@prisma/client");
var log = process.env.NODE_ENV == 'development'
    ? ['query', 'info', "warn", "error"]
    : undefined;
exports.prisma = new client_1.PrismaClient({
    log: log
});
