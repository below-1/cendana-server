"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.toDateUpperLower = void 0;
var date_fns_1 = require("date-fns");
function toDateUpperLower(year, month) {
    var firstDay = 1;
    var lower = new Date(year, month, firstDay);
    var upper = date_fns_1.lastDayOfMonth(lower);
    return {
        lower: lower,
        upper: upper
    };
}
exports.toDateUpperLower = toDateUpperLower;
