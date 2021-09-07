"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserNotFound = exports.InvalidToken = exports.NoAuthHeader = void 0;
var NoAuthHeader = /** @class */ (function (_super) {
    __extends(NoAuthHeader, _super);
    function NoAuthHeader() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return NoAuthHeader;
}(Error));
exports.NoAuthHeader = NoAuthHeader;
var InvalidToken = /** @class */ (function (_super) {
    __extends(InvalidToken, _super);
    function InvalidToken() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return InvalidToken;
}(Error));
exports.InvalidToken = InvalidToken;
var UserNotFound = /** @class */ (function (_super) {
    __extends(UserNotFound, _super);
    function UserNotFound() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return UserNotFound;
}(Error));
exports.UserNotFound = UserNotFound;
