"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.servicio = void 0;
const TourTree_1 = require("../../ParserJavascript/Interprete/TourTree");
const fs = __importStar(require("fs"));
const parse = require('../../../build/ParserJavascript/Analisis/gramatica');
class Servicio {
    Javascript(req, res) {
        try {
            //haciendo el parsing con jison
            var tree = parse.parse(req.body.texto);
            //recorriendo el arbol para crear el dot
            var tour = new TourTree_1.TourTree();
            var dot = tour.getDot(tree.ast);
            let err = tree.errores.reporteErrores();
            let consola = tree.errores.reportConsola();
            tree.errores.reiniciar();
            let reportToken = tree.tokens.reporteTokens();
            tree.tokens.reiniciar();
            //creando el dot y ejecutando el codigo para generar el pdf
            fs.writeFile('codigo.dot', dot, (err) => {
                if (err)
                    throw err;
                tree.ast.execdot();
            });
            res.json({
                responde: "true",
                errores: err,
                consola: consola,
                tokens: reportToken
            });
        }
        catch (error) {
            console.log(error);
            res.json({ responde: "false" });
        }
    }
}
exports.servicio = new Servicio();
