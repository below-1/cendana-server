"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChangePassword = exports.SignUp = exports.Login = void 0;
var typebox_1 = require("@sinclair/typebox");
var Login;
(function (Login) {
    Login.Obj = typebox_1.Type.Object({
        username: typebox_1.Type.String(),
        password: typebox_1.Type.String()
    });
})(Login = exports.Login || (exports.Login = {}));
var SignUp;
(function (SignUp) {
    SignUp.Obj = typebox_1.Type.Object({
        username: typebox_1.Type.String(),
        password: typebox_1.Type.String(),
        name: typebox_1.Type.String()
    });
})(SignUp = exports.SignUp || (exports.SignUp = {}));
var ChangePassword;
(function (ChangePassword) {
    ChangePassword.Obj = typebox_1.Type.Object({
        username: typebox_1.Type.String(),
        password: typebox_1.Type.String()
    });
})(ChangePassword = exports.ChangePassword || (exports.ChangePassword = {}));
