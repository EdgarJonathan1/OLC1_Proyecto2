"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.If = void 0;
const Expression_1 = require("../Expression/Expression");
const Retorno_1 = require("../Expression/Retorno");
class If extends Expression_1.Expression {
    constructor(condicion, body, elseif, line, column) {
        super(line, column);
        this.condicion = condicion;
        this.body = body;
        this.elseif = elseif;
    }
    translate() {
        var result = 'if(' + this.condicion.translate().value + '){\n\t';
        for (var statment of this.body) {
            result += statment.translate().value;
        }
        result += '\n\t}';
        this.elseif.forEach(element => {
            result += element.translate().value;
        });
        let retorno = { value: result, type: Retorno_1.Type.STRING };
        return retorno;
    }
    ast() {
        throw new Error('Method not implemented.');
    }
}
exports.If = If;
