"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ID = void 0;
var typebox_1 = require("@sinclair/typebox");
var ID;
(function (ID) {
    ID.Obj = typebox_1.Type.Object({
        id: typebox_1.Type.Integer(),
    });
})(ID = exports.ID || (exports.ID = {}));
