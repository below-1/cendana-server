"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ROCNotFound = void 0;
var fastify_error_1 = __importDefault(require("fastify-error"));
exports.ROCNotFound = fastify_error_1.default('FST_ROC_NOT_FOUND', "ROC(id=%s) can't be found", 500);
