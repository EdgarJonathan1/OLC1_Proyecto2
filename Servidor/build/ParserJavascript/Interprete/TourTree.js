"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TourTree = void 0;
class TourTree {
    constructor() {
        this.id = 1;
        this.result = "";
    }
    getDot(node) {
        this.result = "";
        this.result += "digraph G {";
        this.tour(node);
        this.result += "}";
        return this.result;
    }
    tour(nodo) {
        if (typeof nodo.valor === "undefined") {
        }
        else {
            //Para los id
            if (nodo.id == 0) {
                nodo.id = this.id;
                this.id++;
            }
            //console.log(nodo);
            //console.log(nodo.id + '[label= "' + nodo.valor + '" fillcolor="#d62728"];\n');
            this.result += nodo.id + '[label= "' + nodo.valor + '" fillcolor="#d62728"];\n';
            nodo.hijos.forEach(element => {
                /* id -> id; */
                //console.log(nodo.id + '->' + this.id + ';');
                this.result += nodo.id + '->' + this.id + ';';
                this.tour(element);
            });
        }
    }
}
exports.TourTree = TourTree;
