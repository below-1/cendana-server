"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Staf = exports.Supplier = exports.Customer = exports.Update = exports.Create = exports.Admin = exports.Find = void 0;
var typebox_1 = require("@sinclair/typebox");
var client_1 = require("@prisma/client");
var find_1 = require("@cend/commons/find");
var Find;
(function (Find) {
    Find.Obj = typebox_1.Type.Intersect([
        find_1.FindOptions.Obj,
        typebox_1.Type.Object({
            keyword: typebox_1.Type.String({ default: '' })
        })
    ]);
})(Find = exports.Find || (exports.Find = {}));
var Admin;
(function (Admin) {
    var Find;
    (function (Find) {
        Find.Obj = typebox_1.Type.Intersect([
            find_1.FindOptions.Obj,
            typebox_1.Type.Object({
                keyword: typebox_1.Type.Optional(typebox_1.Type.String())
            })
        ]);
    })(Find = Admin.Find || (Admin.Find = {}));
})(Admin = exports.Admin || (exports.Admin = {}));
var Create;
(function (Create) {
    Create.Obj = typebox_1.Type.Object({
        name: typebox_1.Type.String(),
        role: typebox_1.Type.Enum(client_1.Role),
        address: typebox_1.Type.Optional(typebox_1.Type.String()),
        mobile: typebox_1.Type.Optional(typebox_1.Type.String()),
        email: typebox_1.Type.Optional(typebox_1.Type.String())
    });
})(Create = exports.Create || (exports.Create = {}));
var Update;
(function (Update) {
    Update.Obj = typebox_1.Type.Object({
        name: typebox_1.Type.Optional(typebox_1.Type.String()),
        address: typebox_1.Type.Optional(typebox_1.Type.String()),
        mobile: typebox_1.Type.Optional(typebox_1.Type.String()),
        email: typebox_1.Type.Optional(typebox_1.Type.String())
    });
})(Update = exports.Update || (exports.Update = {}));
var Customer;
(function (Customer) {
    var Create;
    (function (Create) {
        Create.Obj = typebox_1.Type.Object({
            name: typebox_1.Type.String(),
            address: typebox_1.Type.Optional(typebox_1.Type.String()),
            mobile: typebox_1.Type.Optional(typebox_1.Type.String()),
            email: typebox_1.Type.Optional(typebox_1.Type.String())
        });
    })(Create = Customer.Create || (Customer.Create = {}));
    var Update;
    (function (Update) {
        Update.Obj = typebox_1.Type.Object({
            name: typebox_1.Type.Optional(typebox_1.Type.String()),
            address: typebox_1.Type.Optional(typebox_1.Type.String()),
            mobile: typebox_1.Type.Optional(typebox_1.Type.String()),
            email: typebox_1.Type.Optional(typebox_1.Type.String())
        });
    })(Update = Customer.Update || (Customer.Update = {}));
})(Customer = exports.Customer || (exports.Customer = {}));
var Supplier;
(function (Supplier) {
    var Create;
    (function (Create) {
        Create.Obj = typebox_1.Type.Object({
            name: typebox_1.Type.String(),
            address: typebox_1.Type.String(),
            mobile: typebox_1.Type.String(),
            email: typebox_1.Type.Optional(typebox_1.Type.String())
        });
    })(Create = Supplier.Create || (Supplier.Create = {}));
    var Update;
    (function (Update) {
        Update.Obj = typebox_1.Type.Object({
            name: typebox_1.Type.Optional(typebox_1.Type.String()),
            address: typebox_1.Type.Optional(typebox_1.Type.String()),
            mobile: typebox_1.Type.Optional(typebox_1.Type.String()),
            email: typebox_1.Type.Optional(typebox_1.Type.String())
        });
    })(Update = Supplier.Update || (Supplier.Update = {}));
})(Supplier = exports.Supplier || (exports.Supplier = {}));
var Staf;
(function (Staf) {
    var Create;
    (function (Create) {
        Create.Obj = typebox_1.Type.Object({
            username: typebox_1.Type.String(),
            password: typebox_1.Type.String(),
            name: typebox_1.Type.String()
        });
    })(Create = Staf.Create || (Staf.Create = {}));
    var Update;
    (function (Update) {
        Update.Obj = typebox_1.Type.Object({
            name: typebox_1.Type.Optional(typebox_1.Type.String()),
            username: typebox_1.Type.Optional(typebox_1.Type.String())
        });
    })(Update = Staf.Update || (Staf.Update = {}));
})(Staf = exports.Staf || (exports.Staf = {}));
