"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.createReport = void 0;
var prisma_1 = require("@cend/commons/prisma");
var date_fns_1 = require("date-fns");
var locale_1 = require("date-fns/locale");
function createReport(options) {
    return __awaiter(this, void 0, void 0, function () {
        var startDate, endDate, dateLabel, t0, t1, totalSale, piutang, hppStart, hppEnd, persediaan, pembelianBarangDagang, totalOpex, modalAwal, utangDagang, prive, peralatan, investment, hpp, labaKotor, labaSebelumPajak, labaBersih, modalAkhir, penyusutanTool, aktivaLancar, aktivaTetap, passiva, err_1, report;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    startDate = new Date();
                    startDate = date_fns_1.setYear(startDate, options.year);
                    startDate = date_fns_1.setMonth(startDate, options.month);
                    startDate = date_fns_1.setDate(startDate, 1);
                    endDate = date_fns_1.lastDayOfMonth(startDate);
                    dateLabel = date_fns_1.format(endDate, 'dd MMMM, yyyy', { locale: locale_1.id });
                    t0 = date_fns_1.format(startDate, 'yyyy-MM-dd');
                    t1 = date_fns_1.format(endDate, 'yyyy-MM-dd');
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select sum(t.\"nominal\") as total from \"Order\" o \n      join \"Transaction\" t on t.\"orderId\" = o.id\n      where o.\"orderType\" = 'SALE'\n      and o.\"createdAt\" between '" + t0 + "' and '" + t1 + "'")];
                case 1:
                    totalSale = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select coalesce(sum(d.total), 0) as total\n      from \"Delay\" d\n      where \n        d.type = 'RECEIVABLE'\n        and d.\"createdAt\" between '" + t0 + "' and '" + t1 + "'")];
                case 2:
                    piutang = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select coalesce(sum(rp.available * rp.\"sellPrice\"), 0) as total \n      from \"RecordProduct\" rp where rp.\"date\" = '" + t0 + "'")];
                case 3:
                    hppStart = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select sum(rp.available * rp.\"sellPrice\") total from \"RecordProduct\" rp where rp.\"date\" = '" + t1 + "'")];
                case 4:
                    hppEnd = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select sum(p.available * p.\"sellPrice\") as total from \"Product\" p")];
                case 5:
                    persediaan = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select sum(p.available * p.\"buyPrice\") as total from \"Product\" p")];
                case 6:
                    pembelianBarangDagang = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select coalesce(sum(t.nominal), 0) as total from \"Transaction\" t \n      where t.\"createdAt\" >= '" + t0 + "' and t.\"createdAt\" <= '" + t1 + "' and t.\"opexId\" > 0")];
                case 7:
                    totalOpex = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw(" \n    select coalesce(re.nominal, 0) from \"RecordEquity\" as re\n      where re.\"createdAt\" <= '" + t0 + "'\n  ")];
                case 8:
                    modalAwal = (_a.sent())[0].nominal;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("\n    select coalesce(sum(o.\"grandTotal\"), 0) as total from \"Order\" o \n      where o.\"orderType\" = 'BUY'\n      and o.\"createdAt\" between '" + t0 + "' and '" + t1 + "'")];
                case 9:
                    utangDagang = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw(" \n    select coalesce(sum(t.nominal), 0) as total from \"EquityChange\" as ec\n      left join \"Transaction\" t on t.\"equityChangeId\" = ec.id\n      where t.\"createdAt\" >= '" + t0 + "' AND t.\"createdAt\" <= '" + t1 + "'\n  ")];
                case 10:
                    prive = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("   \n    select sum(t.nominal) as total from \"Transaction\" t \n      where t.\"createdAt\" >= '" + t0 + "' and t.\"createdAt\" <= '" + t1 + "' and t.\"toolId\" > 0")];
                case 11:
                    peralatan = (_a.sent())[0].total;
                    return [4 /*yield*/, prisma_1.prisma.$queryRaw("   \n    select sum(t.nominal) as total from \"Transaction\" t \n      where t.\"createdAt\" >= '" + t0 + "' and t.\"createdAt\" <= '" + t1 + "' and t.\"investmentId\" > 0")
                        // console.log('totalSale = ', totalSale)
                        // console.log('hppStart = ', hppStart)
                    ];
                case 12:
                    investment = (_a.sent())[0].total;
                    hpp = hppStart - hppEnd;
                    labaKotor = totalSale - hpp;
                    labaSebelumPajak = labaKotor - totalOpex;
                    labaBersih = labaSebelumPajak - options.pajak;
                    modalAkhir = modalAwal + (labaBersih - prive);
                    penyusutanTool = peralatan / endDate.getDate();
                    aktivaLancar = totalSale + piutang + persediaan;
                    aktivaTetap = peralatan - penyusutanTool;
                    passiva = utangDagang + modalAkhir;
                    _a.label = 13;
                case 13:
                    _a.trys.push([13, 15, , 16]);
                    return [4 /*yield*/, prisma_1.prisma.financeReport.delete({
                            where: {
                                target: endDate
                            }
                        })];
                case 14:
                    _a.sent();
                    return [3 /*break*/, 16];
                case 15:
                    err_1 = _a.sent();
                    return [3 /*break*/, 16];
                case 16: return [4 /*yield*/, prisma_1.prisma.financeReport.create({
                        data: {
                            target: endDate,
                            totalPenjualan: totalSale,
                            hpp: hpp,
                            labaKotor: labaKotor,
                            labaBersih: labaBersih,
                            modalAwal: modalAwal,
                            modalAkhir: modalAkhir,
                            kas: totalSale,
                            piutang: piutang,
                            persediaan: persediaan,
                            peralatan: peralatan,
                            akumulasiPeralatan: penyusutanTool,
                            aktivaTetap: aktivaTetap,
                            aktivaLancar: aktivaLancar,
                            passiva: passiva,
                            utangDagang: utangDagang,
                            totalRetur: 0,
                            pembelianBarangDagang: pembelianBarangDagang,
                            totalBiayaPengeluaran: totalOpex,
                            pajak: options.pajak
                        }
                    })];
                case 17:
                    report = _a.sent();
                    console.log(report);
                    return [2 /*return*/];
            }
        });
    });
}
exports.createReport = createReport;
