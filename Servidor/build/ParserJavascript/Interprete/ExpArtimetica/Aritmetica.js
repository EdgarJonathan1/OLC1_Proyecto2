"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Aritmetica = void 0;
const Expression_1 = require(".././Expression/Expression");
const Retorno_1 = require("../Expression/Retorno");
class Aritmetica extends Expression_1.Expression {
    constructor(left, right, type, line, column) {
        super(line, column);
        this.left = left;
        this.right = right;
        this.type = type;
    }
    translate() {
        let resultLeft = this.left.translate().value();
        let resultRight = this.right.translate().value();
        let result = resultLeft + '+' + resultRight;
        let retorno = { value: result, type: Retorno_1.Type.STRING };
        return retorno;
    }
    ast() {
        console.log(this.left, this.right, this.type);
        //codigo grapvhiz
    }
}
exports.Aritmetica = Aritmetica;
