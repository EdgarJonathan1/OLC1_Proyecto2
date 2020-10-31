import { Expression } from "./Expression";
import { Retorno,Type } from "./Retorno";

class Primitivo extends Expression{


    constructor(
        private tipo: string,
        private valor: string,
        line: number,
        column: number
    ) {
        super(line, column);
    }


    public translate(): Retorno {
        return {value: this.valor,type:Type.STRING}
    }
    public ast(): void {
        throw new Error("Method not implemented.");
    }
}

export{Primitivo}