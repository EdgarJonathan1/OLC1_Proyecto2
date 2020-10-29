"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Aritmetica = void 0;
const Expression_1 = require("./Expression");
class Aritmetica extends Expression_1.Expression {
    constructor(left, right, type, line, column) {
        super(line, column);
        this.left = left;
        this.right = right;
        this.type = type;
    }
    translate() {
        throw new Error("Method not implemented.");
        //codigo traducido
    }
    ast() {
        console.log(this.left, this.right, this.type);
        //codigo grapvhiz
    }
}
exports.Aritmetica = Aritmetica;
