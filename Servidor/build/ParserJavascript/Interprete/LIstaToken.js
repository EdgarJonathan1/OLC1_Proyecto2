"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ListaToken = void 0;
class ListaToken {
    constructor() {
        this.ListaE = new Array();
    }
    insertar(nodoN) {
        this.ListaE.push(nodoN);
    }
    getLista() {
        return this.ListaE;
    }
    reporteTokenes() {
        let c = "";
        c += "<tr><td>No.</td><td>Tipo Token</td><td>Fila</td><td>Columna</td><td>Descripcion</td></tr>";
        let n = 1;
        for (let i of this.ListaE) {
            c += "<tr><td>" + n + "</td><td>" + i.tipo + "</td><td>" + i.linea + "</td><td>" + i.columna + "</td><td>" + i.descripcion + "</td></tr>\n";
            n++;
        }
        return c;
    }
    reportConsola() {
        let result = "";
        for (let i of this.ListaE) {
            result += "Token " + i.tipo + ", linea: " + i.linea + ", columna: " + i.columna + "\n\t " + i.descripcion + "\n";
        }
        return result;
    }
    reiniciar() {
        this.ListaE = new Array();
    }
}
exports.ListaToken = ListaToken;
