"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Nodo = void 0;
const child_process_1 = require("child_process");
class Nodo {
    constructor(valor, tipo) {
        this.valor = valor;
        this.tipo = tipo;
        this.id = 0;
        this.hijos = [];
    }
    execdot() {
        child_process_1.spawn('dot', ['-Tpdf', '-o', './AST.pdf', 'codigo.dot']);
    }
    getValor() {
        return this.valor;
    }
    getTipo() {
        return this.getTipo;
    }
    add(node) {
        this.hijos.push(node);
    }
}
exports.Nodo = Nodo;
