"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Primitivo = void 0;
class Primitivo {
    constructor(tipo, valor, fl, cl) {
        this.line = 0;
        this.column = 0;
        this.tipo = tipo;
        this.valor = valor;
        this.fila = fl;
        this.columna = cl;
        // console.log("Primitivo ");
    }
    translate() {
        throw new Error("Method not implemented.");
    }
    ast() {
        throw new Error("Method not implemented.");
    }
}
exports.Primitivo = Primitivo;
