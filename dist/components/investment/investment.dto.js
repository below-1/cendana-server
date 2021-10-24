"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Find = exports.Update = exports.Create = void 0;
var typebox_1 = require("@sinclair/typebox");
var find_1 = require("@cend/commons/find");
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        title: typebox_1.Type.String(),
        description: typebox_1.Type.Optional(typebox_1.Type.String())
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        title: typebox_1.Type.Optional(typebox_1.Type.String()),
        description: typebox_1.Type.Optional(typebox_1.Type.String())
    });
})(Update = exports.Update || (exports.Update = {}));
var Find;
(function (Find) {
    Find.Obj = typebox_1.Type.Intersect([
        typebox_1.Type.Object({
            keyword: typebox_1.Type.String({ default: '' })
        }),
        find_1.FindOptions.Obj
    ]);
})(Find = exports.Find || (exports.Find = {}));
