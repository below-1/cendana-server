"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Report1 = void 0;
var typebox_1 = require("@sinclair/typebox");
var Report1;
(function (Report1) {
    Report1.Obj = typebox_1.Type.Object({
        year: typebox_1.Type.Number(),
        month: typebox_1.Type.Number()
    });
})(Report1 = exports.Report1 || (exports.Report1 = {}));
