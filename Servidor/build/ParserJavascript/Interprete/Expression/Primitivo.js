"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Primitivo = void 0;
const Expression_1 = require("./Expression");
const Retorno_1 = require("./Retorno");
class Primitivo extends Expression_1.Expression {
    constructor(tipo, valor, line, column) {
        super(line, column);
        this.tipo = tipo;
        this.valor = valor;
    }
    translate() {
        return { value: this.valor, type: Retorno_1.Type.STRING };
    }
    ast() {
        throw new Error("Method not implemented.");
    }
}
exports.Primitivo = Primitivo;
