"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.prisma = void 0;
var fastify_plugin_1 = __importDefault(require("fastify-plugin"));
var client_1 = require("@prisma/client");
exports.prisma = new client_1.PrismaClient();
exports.default = fastify_plugin_1.default(function (fastify) {
    fastify.decorate('prisma', exports.prisma);
});
