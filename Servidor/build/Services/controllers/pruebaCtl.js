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
Object.defineProperty(exports, "__esModule", { value: true });
exports.servicio = void 0;
const parse = require('../../../build/ParserJavascript/Analisis/gramatica');
class Servicio {
    prueba(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                var result = parse.parse(req.body.texto);
                console.log(req.body);
                console.log(result);
                res.json({ responde: result });
                //res.json({ responde:req.body.texto});
            }
            catch (error) {
                console.log(error);
            }
        });
    }
}
exports.servicio = new Servicio();
