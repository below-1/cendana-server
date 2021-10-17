"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LabaRugi = exports.RespType = exports.RespTypeEnum = void 0;
var typebox_1 = require("@sinclair/typebox");
var RespTypeEnum;
(function (RespTypeEnum) {
    RespTypeEnum["JSON"] = "JSON";
    RespTypeEnum["WORD"] = "WORD";
})(RespTypeEnum = exports.RespTypeEnum || (exports.RespTypeEnum = {}));
var RespType;
(function (RespType) {
    RespType.Obj = typebox_1.Type.Object({
        type: typebox_1.Type.Enum(RespTypeEnum)
    });
})(RespType = exports.RespType || (exports.RespType = {}));
var LabaRugi;
(function (LabaRugi) {
    LabaRugi.Obj = typebox_1.Type.Object({
        month: typebox_1.Type.Number(),
        year: typebox_1.Type.Number(),
        pajak: typebox_1.Type.Number()
    });
})(LabaRugi = exports.LabaRugi || (exports.LabaRugi = {}));
