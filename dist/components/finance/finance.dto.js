"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LabaRugi = void 0;
var typebox_1 = require("@sinclair/typebox");
var LabaRugi;
(function (LabaRugi) {
    LabaRugi.Obj = typebox_1.Type.Object({
        month: typebox_1.Type.Number(),
        year: typebox_1.Type.Number()
    });
})(LabaRugi = exports.LabaRugi || (exports.LabaRugi = {}));
